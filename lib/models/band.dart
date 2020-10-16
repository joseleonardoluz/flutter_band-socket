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
    id: obj['id'],
    name: obj['name'],
    votes: obj['votes'],
    episodio: obj['episodio'],
    fecha: obj['fecha'],
    duration: obj['duracion'],
  );
}