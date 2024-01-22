class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  Person copyWith({
    String? name,
    int? age,
  }) {
    return Person(
      name ?? this.name,
      age ?? this.age,
    );
  }
}
