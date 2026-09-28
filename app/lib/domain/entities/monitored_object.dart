class MonitoredObject {
  const MonitoredObject({
    required this.id,
    required this.label,
    required this.emoji,
    required this.modelClassIndex,
  });

  final String id;
  final String label;
  final String emoji;
  final int modelClassIndex;
}

abstract class MonitoredObjects {
  static const all = [
    MonitoredObject(id: 'key', label: 'Chave', emoji: '🔑', modelClassIndex: 0),
    MonitoredObject(id: 'wallet', label: 'Carteira', emoji: '👛', modelClassIndex: 1),
    MonitoredObject(id: 'phone', label: 'Celular', emoji: '📱', modelClassIndex: 2),
    MonitoredObject(id: 'bag', label: 'Mochila', emoji: '🎒', modelClassIndex: 3),
    MonitoredObject(id: 'door', label: 'Porta', emoji: '🚪', modelClassIndex: 4),
    MonitoredObject(id: 'stove', label: 'Fogão', emoji: '🔥', modelClassIndex: 5),
    MonitoredObject(id: 'window', label: 'Janela', emoji: '🪟', modelClassIndex: 6),
    MonitoredObject(id: 'faucet', label: 'Torneira', emoji: '🚰', modelClassIndex: 7),
    MonitoredObject(id: 'charger', label: 'Carregador', emoji: '🔌', modelClassIndex: 8),
    MonitoredObject(id: 'umbrella', label: 'Guarda-chuva', emoji: '☂️', modelClassIndex: 9),
    MonitoredObject(id: 'medication', label: 'Remédio', emoji: '💊', modelClassIndex: 10),
    MonitoredObject(id: 'iron', label: 'Ferro de passar', emoji: '🧹', modelClassIndex: 11),
    MonitoredObject(id: 'glasses', label: 'Óculos', emoji: '👓', modelClassIndex: 12),
    MonitoredObject(id: 'earbuds', label: 'Fones', emoji: '🎧', modelClassIndex: 13),
    MonitoredObject(id: 'watch', label: 'Relógio', emoji: '⌚', modelClassIndex: 14),
    MonitoredObject(id: 'laptop', label: 'Notebook', emoji: '💻', modelClassIndex: 15),
    MonitoredObject(id: 'handbag', label: 'Bolsa', emoji: '👜', modelClassIndex: 16),
    MonitoredObject(id: 'car_key', label: 'Chave de carro', emoji: '🔑', modelClassIndex: 17),
    MonitoredObject(id: 'water_bottle', label: 'Garrafa de água', emoji: '🍶', modelClassIndex: 18),
    MonitoredObject(id: 'jacket', label: 'Casaco', emoji: '🧥', modelClassIndex: 19),
    MonitoredObject(id: 'padlock', label: 'Cadeado', emoji: '🔒', modelClassIndex: 20),
    MonitoredObject(id: 'leash', label: 'Coleira', emoji: '🐕', modelClassIndex: 21),
  ];

  static MonitoredObject byId(String id) => all.firstWhere((e) => e.id == id, orElse: () => all.first);
}
