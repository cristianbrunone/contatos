class Contato {
  String title;
  String subtitle;
  String telefone;
  String cep;
  String email;
  String? imageURL;

  Contato({
    this.title = "",
    this.subtitle = "",
    this.telefone = "",
    this.cep = "",
    this.email = "",
    this.imageURL,
  });
  set setImageURL(String url) {
    // Converter para um setter
    this.imageURL = url;
  }
}

List<Contato> contatos = [
  Contato(
      title: "Vamos",
      subtitle: "Brunone",
      telefone: "47 98857-2897",
      cep: "89230-410",
      email: "cristianbruone@gmail.com"),
  Contato(
      title: "Brian",
      subtitle: "Cordero",
      telefone: "47 98857-2897",
      cep: "89230-410",
      email: "example@gmail.com"),
  Contato(
      title: "Angelina",
      subtitle: "Moises",
      telefone: "47 98857-2897",
      cep: "89230-410",
      email: "example@gmail.com"),
];
