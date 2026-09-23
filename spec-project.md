# Toc Toc — Documento de Requisitos (MVP)

> **Status:** MVP | **Plataforma:** Flutter (Android e iOS) | **Processamento:** 100% on-device, sem backend, sem conta de usuário
> **Princípio norteador:** a confirmação do app é tratada como definitiva — o produto não deve incentivar checagem repetida.

## Sumário

- [1. Visão Geral](#1-visão-geral)
- [2. Escopo do MVP](#2-escopo-do-mvp)
- [3. Requisitos Funcionais](#3-requisitos-funcionais)
- [4. Requisitos Não Funcionais](#4-requisitos-não-funcionais)
- [5. Arquitetura Técnica](#5-arquitetura-técnica)
- [6. Princípios de UX](#6-princípios-de-ux-não-negociáveis-para-o-mvp)
- [7. Métricas de Sucesso](#7-métricas-de-sucesso-do-mvp)
- [8. Riscos e Pontos em Aberto](#8-riscos-e-pontos-em-aberto)
- [9. Apêndice — Mapeamento para Implementação](#9-apêndice--mapeamento-para-implementação)

---

## 1. Visão Geral

**Problema:** pessoas sentem dúvida ou ansiedade recorrente sobre ter pegado itens essenciais (chave, carteira, celular) antes de sair de casa — em casos de ansiedade de verificação, isso leva a checagens repetidas ou retorno físico para conferir.

**Solução:** app mobile que usa a câmera do celular e um modelo de visão computacional on-device para confirmar objetivamente, em segundos, que os itens do checklist estão no lugar de sempre — sem enviar dados para nuvem.

**Público-alvo:** pessoas com rotina de saída de casa que querem reduzir a fricção mental de conferência manual, com atenção especial a quem tem ansiedade de verificação (TOC).

**Plataforma:** Flutter (Android e iOS).

**Princípio norteador:** a confirmação do app é tratada como definitiva. O produto não deve incentivar checagem repetida — isso orienta decisões de UX descritas na [seção 6](#6-princípios-de-ux-não-negociáveis-para-o-mvp).

---

## 2. Escopo do MVP

### Dentro do escopo

- Configuração de checklist visual (captura de referência dos itens)
- Checagem diária por câmera comparando com a referência salva
- Feedback de confirmação (sucesso) ou alerta (item faltando)
- Histórico simples de dias confirmados
- Lembrete local por horário (notificação agendada)
- Lembrete por geolocalização (aviso único ao sair de casa sem confirmar)
- Processamento 100% on-device, sem conta de usuário, sem backend

### Fora do escopo (v2+)

- Múltiplos locais (trabalho, carro) além de "casa"
- Múltiplos checklists (ex: um pra sair de casa, outro pra viagem)
- Sincronização entre dispositivos / conta de usuário
- Compartilhamento de checklist entre pessoas (ex: família)
- Fine-tuning de modelo customizado por classe de objeto
- Push notification remoto / backend
- Métricas de uso enviadas para servidor (analytics)

---

## 3. Requisitos Funcionais

### RF01 — Configuração do checklist

- O usuário deve poder apontar a câmera para o local de referência e capturar a cena.
- O sistema deve identificar regiões de objetos na imagem e permitir que o usuário selecione quais monitorar.
- O usuário deve poder nomear/rotular cada item (ex: "Chave", "Carteira").
- A referência visual de cada item selecionado deve ser salva localmente.
- O usuário deve poder editar o checklist depois (adicionar, remover, recapturar um item).

### RF02 — Checagem diária

- O usuário deve poder iniciar uma checagem apontando a câmera para o local configurado.
- O sistema deve comparar os itens visíveis no frame atual com as referências salvas.
- O resultado deve ser exibido em até poucos segundos de captura.

### RF03 — Feedback de resultado

- Se todos os itens do checklist forem detectados: exibir confirmação de sucesso com carimbo de horário.
- Se algum item não for detectado: exibir alerta indicando especificamente qual item está faltando.
- A tela de sucesso não deve oferecer um botão proeminente de "escanear novamente".

### RF04 — Histórico

- O sistema deve registrar, por dia, se houve confirmação (e a que horas).
- O usuário deve poder visualizar um resumo (ex: "X de Y dias confirmados no mês").

### RF05 — Lembrete por horário

- O usuário deve poder definir um horário aproximado de saída.
- O sistema deve notificar localmente nesse horário somente se o checklist do dia ainda não tiver sido confirmado.

### RF06 — Lembrete por localização (opt-in)

- O usuário deve poder ativar, de forma explícita e opcional, um lembrete baseado em localização.
- O usuário deve definir "minha casa" (localização + raio).
- O sistema deve monitorar saída da geofence em segundo plano.
- Ao detectar saída: notificar apenas se o checklist do dia não tiver sido confirmado.
- O sistema não deve notificar mais de uma vez por dia, independente de quantas vezes o usuário saia e volte.
- O usuário deve poder desativar esse recurso a qualquer momento, separadamente do restante do app.

### RF07 — Onboarding

- Explicar de forma simples e não-clínica o que o app faz.
- Solicitar permissões (câmera, notificações, localização em segundo plano) apenas no momento em que são necessárias, com justificativa clara de uso.

---

## 4. Requisitos Não Funcionais

| Categoria | Requisito |
|---|---|
| **Privacidade** | Nenhuma imagem ou dado de localização deixa o dispositivo. Todo processamento é local. |
| **Desempenho** | Checagem diária deve concluir em até ~3 segundos após apontar a câmera. |
| **Bateria** | Monitoramento de geofence deve usar API nativa otimizada do SO, não GPS contínuo. |
| **Acessibilidade** | Contraste adequado, suporte a leitor de tela nos elementos principais, texto redimensionável. |
| **Offline** | App deve funcionar 100% sem conexão à internet. |
| **Compatibilidade** | Android 8+ e iOS 14+ (ajustar conforme suporte mínimo do `tflite_flutter` e `camera`). |

---

## 5. Arquitetura Técnica

### Modelo de visão

MobileNetV2/V3 (`.tflite`, via Kaggle Models ou Hugging Face `litert-community`), usado como **extrator de embeddings** — comparação por similaridade entre a referência salva e o frame atual, em vez de classificação fixa por categoria.

### Stack Flutter

| Biblioteca | Papel no MVP |
|---|---|
| `camera` | captura de imagem |
| `tflite_flutter` | inferência do modelo on-device |
| `hive` | persistência local (checklist, embeddings, histórico, estado de confirmação/lembrete) |
| `flutter_local_notifications` | lembrete por horário e por geofence |
| `geofence_service` (ou equivalente) | monitoramento de localização em segundo plano |
| `get_it` + `flutter_bloc` + `go_router` | arquitetura em camadas (ver `AGENTS.md`) |

### Dados armazenados localmente

- Lista de itens do checklist (nome + embedding de referência)
- Histórico de confirmações (data + hora)
- Configuração de lembretes (horário, geofence ativada/desativada, coordenadas de "casa")
- Data do último lembrete enviado (para a regra de "uma vez por dia")

> Arquitetura em camadas segue `AGENTS.md`: `domain/` puro, `data/` implementa contratos, `presenter/` consome via BLoC, `GetIt` apenas no `app_module.dart`, modelos com `freezed`.

---

## 6. Princípios de UX (não negociáveis para o MVP)

> Como o produto lida diretamente com um padrão comportamental sensível (verificação compulsiva), estas diretrizes têm prioridade sobre decisões estéticas ou de conveniência.

1. **Confirmação é definitiva.** Nenhuma tela de sucesso deve convidar a checar de novo.
2. **Notificações são condicionais, nunca repetitivas.** Um lembrete só existe se ainda não houve confirmação, e no máximo uma vez por dia por canal.
3. **Tom neutro e gentil.** Nenhum texto de alerta ou lembrete deve soar como cobrança ou reprimenda.
4. **Histórico constrói confiança, não ansiedade** — é apresentado como reforço positivo, não como cobrança de sequência perfeita.
5. **Permissões sensíveis são opt-in e explicadas.** Em especial, localização em segundo plano nunca deve ser obrigatória para o uso básico do app.

---

## 7. Métricas de Sucesso do MVP

- Taxa de conclusão do onboarding (configuração do primeiro checklist)
- Frequência de uso diário / retenção em 7 e 30 dias
- Proporção de confirmações com sucesso vs. alerta de item faltando
- Taxa de ativação do lembrete por localização (opt-in)
- Feedback qualitativo: o app reduziu a necessidade de checagem física/repetida? (via pesquisa simples in-app ou entrevistas)

---

## 8. Riscos e Pontos em Aberto

- **Confiabilidade do modelo:** falso negativo (item está lá, mas não detectado) pode gerar alerta desnecessário e, paradoxalmente, aumentar ansiedade. Vale definir um limiar de confiança testado com usuários reais antes do lançamento.
- **Permissão de localização em segundo plano:** pode ser rejeitada em review de loja se a justificativa não for clara; ter fluxo de explicação robusto.
- **Validação clínica:** recomenda-se revisão do fluxo de UX com profissional especializado em TOC (terapia de exposição e prevenção de resposta) antes do lançamento público.
- **Iluminação/ângulo variável:** a checagem depende de o usuário apontar pro mesmo local nas mesmas condições — variações de luz podem afetar a comparação por similaridade.

---

## 9. Apêndice — Mapeamento para Implementação

> Referência para seguir o checklist de `AGENTS.md §14` ao criar cada feature.

| Requisito | Feature sugerida | Entities (`domain/entities/`) | Repository (`domain/repositories/`) |
|---|---|---|---|
| RF01 | `presenter/checklist` | `ChecklistItem` (nome + embedding) | `ChecklistRepository` |
| RF02/RF03 | `presenter/check` | `CheckResult` | `VisionRepository` (tflite) |
| RF04 | `presenter/history` | `DailyConfirmation` | `HistoryRepository` (hive) |
| RF05/RF06 | `presenter/reminders` | `ReminderConfig` | `ReminderRepository` + `GeofenceService` |
| RF07 | `presenter/onboarding` | — | — |

Fluxo técnico MVP: `camera` → `tflite_flutter` (embedding) → comparação similaridade → `hive` (persistência) → `flutter_local_notifications`/`geofence_service` (lembretes).
