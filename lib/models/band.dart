class Band {

  String id;
  String name;
  int votes;
  String episodio;
  String fecha;
  String duration;

  Band({
    this.id,
    this.name,
    this.votes,
    this.episodio,
    this.fecha,
    this.duration

  });

  factory Band.fromMap(Map<String, dynamic> obj)

  => Band(
    id: obj.containsKey('id') ? obj['id']: 'no-id',
    name: obj.containsKey('name') ? obj['name']: 'no-name',
    votes: obj.containsKey('votes') ? obj['votes']: 'no-votes',
    episodio: obj.containsKey('episodio') ? obj['episodio']: 'no-episodio',
    fecha: obj.containsKey('fecha') ? obj['fecha']: 'no-fecha',
    duration: obj.containsKey('fecha') ? obj['fecha']: 'no-fecha',
  );
}