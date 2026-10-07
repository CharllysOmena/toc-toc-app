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

**Problema:** pessoas sentem dúvida ou ansiedade recorrente sobre ter pegado itens essenciais (chave, carteira, celular) antes de sair de casa — em casos de ansiedade de verificação, isso leva a checagens repetidas ou retorno físico para conferir. O mesmo padrão se estende a conferências domésticas (fechar porta, desligar fogão, janela, torneira, etc.).

**Solução:** app mobile onde o usuário cria **itens de conferência** (ex: "Fechar porta", "Desligar fogão") definindo **título**, **objeto monitorado** (catálogo para checagem por IA), **dias da semana** que deve lembrar e **horário**. O app **notifica localmente** nesses dias/horários e permite **registrar a conferência com foto da câmera** (on-device, sem nuvem). Cada item pode ser verificado, editado ou apagado.

**Público-alvo:** pessoas com rotina de conferências domésticas/semanais que querem reduzir a fricção mental de checagem manual, com atenção especial a quem tem ansiedade de verificação (TOC).

**Plataforma:** Flutter (Android e iOS). Captura de foto com câmera real; inferência de IA (visão) prevista mas **não integrada nesta fase** — a captura marca o registro como confirmado (placeholder).

**Princípio norteador:** a confirmação do app é tratada como definitiva. O produto não deve incentivar checagem repetida — isso orienta a UX (sem botão proeminente de “registrar de novo” quando já registrado no dia).

---

## 2. Escopo do MVP

### Dentro do escopo

- **Primeiro acesso:** `Welcome` exibido apenas na primeira abertura; depois o app abre direto na listagem de itens.
- **Listagem de itens:** lista plana de itens com **filtro `Hoje` (dia atual) ou `Todos`**; item registrado no dia recebe sinalização verde (card com fundo `confirmBg` / badge “Registrado”).
- **Cadastro/edição/exclusão de item:** título, **objeto monitorado** (select com catálogo: Chave, Carteira, Celular, Mochila, Porta, Fogão, Janela, Torneira, Carregador, Guarda-chuva, Remédio, Ferro, etc.), **dias da semana** e **horário**.
- **Registro por câmera:** ao tocar no card do item, abre a câmera (ou, se já registrado hoje, mostra direto a tela de **Confirmado** já existente); na câmera: preview real + overlay do viewfinder + botão **Registrar** para tirar a foto.
- **Feedback de registro:** após a captura, exibe **Confirmado** com carimbo de horário. Quando a IA for integrada, também haverá o estado **Item faltando** já existente. A tela de sucesso não tem CTA de “registrar de novo”.
- **Histórico por item:** por item, calendário de dias confirmados (mesma grade 7 colunas já existente).
- **Lembretes locais:** **notificações locais** (`flutter_local_notifications`) agendadas por **horário + dias** de cada item; são locais, sem backend, e respeitam “não notificar se já registrado no dia” via sincronização ao abrir o app / ao registrar.
- **Processamento 100% on-device**, sem conta de usuário, sem backend; persistência via `shared_preferences`.

### Fora do escopo (v2+)

- **Inferência por IA em tempo real** (`flutter_litert` + modelo MobileNet embeddings) — interface `CheckAiService` já criada, implementação real entra quando houver `.tflite` em `assets/models/`; hoje o resultado é confirmado ao capturar.
- Lembrete por **geofence/localização** (saiu de casa) — citado no MVP antigo, agora adiado.
- Múltiplos locais (trabalho, carro) além de "casa".
- Sincronização entre dispositivos / conta de usuário.
- Compartilhamento de itens entre pessoas (ex: família).
- Fine-tuning de modelo customizado por classe de objeto.
- Push remoto / backend.
- Métricas de uso enviadas para servidor (analytics).

---

## 3. Requisitos Funcionais

### RF01 — Listagem de itens (filtro por dia)

- Ao abrir o app (após o primeiro acesso), exibir a listagem de itens em `Tabs`/`chips` **`Hoje` | `Todos`** (default `Hoje` = dia da semana atual).
- `Hoje` mostra apenas itens cujo `weekDays` contém o dia atual; `Todos` mostra todos.
- Cada card exibe: título, objeto (emoji + label), `HH:mm`, chips dos dias, e **badge verde** quando `registeredAt` é hoje.

### RF02 — Cadastro/edição/exclusão de item

- O usuário deve poder tocar em **Adicionar item** (FAB) e preencher **título** (obrigatório), **objeto** (select do catálogo), **dias** (FilterChip, ≥1 dia obrigatório), **horário** (`showTimePicker`).
- Ao salvar, validar título e dias, persistir, **agendar/atualizar notificações** e voltar à lista (com refresh).
- Em cada card: menu **Editar** (→ form preenchido) e **Excluir** (apaga item, histórico e cancela notificações).

### RF03 — Registro por câmera (foto)

- Um item só pode ser registrado **no dia** em que está em `weekDays` e **dentro da janela de tolerância de ±1 h** ao redor de `time` (ex: 08:00 → 07:00–09:00, mesmo dia civil). Fora dessa janela ou dia, o card fica **Indisponível** com mensagem e botão desabilitado; o toque mostra `SnackBar` com o motivo.
- Itens registrados permanecem visíveis com badge **Registrado** verde, mesmo fora da janela, e continuam aparecendo no filtro `Todos` porém bloqueados.
- Ao tocar no card do item:
  - Se **já registrado hoje** → navegar direto para **Confirmado** (carimbo de horário, `StreakBanner`, sem CTA de novo registro).
  - Se **não registrado e dentro da janela** → abrir tela de câmera (permissão pedida no momento do uso, com justificativa pt-BR) com **preview real**, overlay do viewfinder e botão **Registrar** (tira foto).
  - Se **fora da janela/dia** → tela **Indisponível** (ícone de relógio + motivo + `windowLabel` e botão Voltar).
- Nesta fase, a foto é capturada e o registro é marcado como confirmado (placeholder da IA); a interface `CheckAiService` já isola a futura inferência.
- Se a IA **não detectar** o objeto monitorado, o item entra no estado **Item faltando**, com as ações **Tentar novamente** e **Confirmar manualmente**. A confirmação manual respeita a mesma janela/dia de RF03 e registra o dia como confirmado, sinalizando que a confirmação foi manual.

### RF04 — Feedback de registro

- Se registrado com sucesso pela IA: **Confirmado** com horário do registro + `StreakBanner` "Registrado com sucesso".
- Se o objeto monitorado não for detectado → estado **Item faltando** (banner `alertBg`, lista de status), já existente em `check_page.dart`, com opção de **Confirmar manualmente**.
- Se confirmado manualmente: **Confirmado** com carimbo de horário + `StreakBanner` "Confirmado manualmente"; o dia aparece com marca de edição no **Histórico** (`HistoryEntry.manual`).
- A tela de sucesso não oferece botão proeminente de "registrar novamente" (princípio da confirmação definitiva).

### RF05 — Histórico por item

- Por item, exibir calendário dos últimos 30 dias (grade 7) e contador `X/Y` dias confirmados no mês.
- O histórico é por `itemId` (chave `toc_history_<itemId>`).

### RF06 — Lembretes locais (notificações)

- Ao criar/editar itens, **agendar notificações locais semanais** por item e por dia selecionado no horário definido.
- Ao abrir o app e ao registrar um item, **sincronizar**: se o item foi registrado hoje, **não notificar** hoje (cancela/adiapta a ocorrência do dia).
- Solicitar **permissão de notificações** no momento de salvar o primeiro item, com explicação.

### RF07 — Onboarding e permissões

- **Welcome** (`Confira uma vez. Siga em paz.`) exibido apenas na primeira abertura (`hasSeenWelcome` em `shared_preferences`); depois redireciona para `/checklist`.
- Permissões (**câmera** e **notificações**) pedidas apenas quando necessárias, com strings pt-BR em `AndroidManifest.xml`/`Info.plist` e diálogo de justificativa.

---

## 4. Requisitos Não Funcionais

| Categoria | Requisito |
|---|---|
| **Privacidade** | Nenhuma foto sai do dispositivo. Processamento local; notificações locais sem servidor. |
| **Desempenho** | Abertura da câmera e captura devem ser fluidas (< 2 s para ficar pronta); registro marca o dia imediatamente após a foto. |
| **Bateria** | Notificações usam `flutter_local_notifications` com agendamento por `dayOfWeekAndTime`; sem polling contínuo. |
| **Acessibilidade** | Contraste (`ink`/`inkSoft` sobre `panel`), semântica de botões/cards, texto redimensionável; chips com `Semantics`. |
| **Offline** | Funciona 100% sem internet. |
| **Compatibilidade** | Android 8+ e iOS 14+ (ajustar ao `minSdk` do `camera`/`flutter_local_notifications`). |

---

## 5. Arquitetura Técnica

### Visão de registro (sem IA nesta fase)

`ChecklistItem` (plano) → `camera` (foto) → `CheckAiService` (placeholder = confirmado) → `checklist_repository.markRegistered` + `history_repository.addToday` → **Confirmado**; `NotificationService` resincroniza.

### Stack Flutter

| Biblioteca | Papel no MVP |
|---|---|
| `camera` | captura de foto (preview + `takePicture`) |
| `shared_preferences` | persistência de itens, histórico, `hasSeenWelcome` |
| `flutter_local_notifications` + `timezone`/`flutter_timezone` | agendamento por horário + dias |
| `flutter_secure_storage` | reservado para tokens futuros (não usado no fluxo de lembretes) |
| `hive` | **substituído** por `shared_preferences` no MVP (dados JSON) |
| `flutter_litert` | **previsto** (não integrado; atrás de `CheckAiService`) |
| `get_it` + `flutter_bloc` + `go_router` | arquitetura em camadas (ver `AGENTS.md`) |
| `google_fonts` | tipografia (`Fraunces`/`Inter`) |

### Dados armazenados localmente

- Itens: `toc_checklist_items` → `List<ChecklistItem>` JSON (`id`, `title`, `objectId`, `time: DayTime`, `weekDays`, `createdAt`, `registeredAt`)
- Catálogo de objetos: `MonitoredObject` (`id/label/emoji`) — `MonitoredObjects.all` em `domain` (puro Dart)
- Histórico por item: `toc_history_<itemId>` → `List<HistoryEntry>` (`date`, `confirmed`, `confirmedAt`, `photoPath`, `manual`)
- Flag de onboarding: `toc_welcome_seen: bool`

> Arquitetura em camadas segue `AGENTS.md`: `domain/` puro, `data/` implementa contratos, `presenter/` consome via BLoC, `GetIt` apenas no `app_module.dart`, modelos com `freezed`.

---

## 6. Princípios de UX (não negociáveis para o MVP)

> Como o produto lida com um padrão comportamental sensível (verificação compulsiva), estas diretrizes têm prioridade sobre decisões estéticas.

1. **Confirmação é definitiva.** Nenhuma tela de sucesso convida a registrar de novo (sem CTA proeminente).
2. **Notificações são condicionais.** Um lembrete existe no horário/dia, mas a UI não cobra se já houve registro hoje; o card fica verde.
3. **Tom neutro e gentil.** Textos de alerta/lembrete sem cobrança ou reprimenda.
4. **Histórico constrói confiança, não ansiedade** — reforço positivo, não cobrança de sequência perfeita.
5. **Permissões no uso e explicadas.** Câmera ao tocar para registrar; notificações ao criar o primeiro item; nunca obrigatórias para navegar na lista.

---

## 7. Métricas de Sucesso do MVP

- Taxa de conclusão do welcome → criação do primeiro item.
- Itens criados por usuário e retenção do uso diário (filtro `Hoje`).
- Taxa de itens registrados no dia vs. lembretes disparados.
- Taxa de conclusão do registro por câmera (foto tirada vs. abandono).
- Feedback: o app reduziu a necessidade de checagem repetida?

---

## 8. Riscos e Pontos em Aberto

- **IA integrada (YOLO-World):** inferência on-device via `flutter_litert` com `assets/models/yoloworld.tflite` (float16, 22 classes). O modelo é sensível à escala (só detecta o objeto ocupando ~25–40% do quadro), então a checagem usa **multi-escala** `[1.0, 0.7, 0.5, 0.35]` com *early exit*, tomando o maior score da classe alvo. Limiar de confiança configurável por `--dart-define=AI_CONF_THRESHOLD` (default 0.30; IoU 0.45). Se não houver foto ou a inferência falhar, o resultado é **não detectado** (estado “Item faltando”), sem registrar o dia. Validar o limiar em devices reais para não gerar falsos negativos/positivos que aumentem ansiedade.
- **Notificações exatas e permissões:** em Android 13+ é preciso `POST_NOTIFICATIONS` e `SCHEDULE_EXACT_ALARM`; o rationale deve ser claro para não ser rejeitado em review.
- **Câmera/permissão de status:** fluxo de negação + “abrir ajustes” com diálogo em pt-BR.
- **Resincronia de agenda:** como as notificações são semanais (`dayOfWeekAndTime`), o app resincroniza ao abrir e ao registrar (cancela o dia se já registrado) — documentar a limitação de “uma vez por semana por dia”.
- **Validação clínica:** revisão do fluxo com profissional de TOC (EPR) antes do lançamento.

---

## 9. Apêndice — Mapeamento para Implementação

> Referência para seguir o checklist de `AGENTS.md §14` ao criar cada feature.

| Requisito | Feature sugerida | Entities (`domain/entities/`) | Repository (`domain/repositories/`) |
|---|---|---|---|
| RF01 | `presenter/checklist` (listagem + filtro) | `ChecklistItem`, `MonitoredObject`, `DayTime` | `ChecklistRepository` (`getAll/getByDay/getById`) |
| RF02 | `presenter/checklist` (form) | — | `ChecklistRepository` (`create/update/delete`) + `NotificationService` |
| RF03/RF04 | `presenter/check` | `CheckResult` | `CheckRepository` + `CheckAiService` (placeholder) + `CameraService` |
| RF05 | `presenter/history` | `HistoryEntry` | `HistoryRepository` (por `itemId`) |
| RF06 | — (serviço) | — | `NotificationService` + `PreferencesService` |
| RF07 | `presenter/welcome` (`presenter/welcome`) | — | `OnboardingRepository` |

Fluxo técnico MVP: `checklist` (lista `Hoje`/`Todos`) → `check` (`camera` foto) → `CheckAiService` (placeholder) → `markRegistered` + `history` → **Confirmado**; `NotificationService.syncAll` agenda por `(item, dias, horário)`.

