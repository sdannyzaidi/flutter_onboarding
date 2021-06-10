String nameValidator(String name) {
  if (name.isEmpty) {
    return "Field can not be empty.";
  } else if (name.length > 30) {
    return "Name cannot exceed 30 characters.";
  }
  return null;
}
