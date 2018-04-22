package xyz.juraszek.bridge;

public class DbPersonNamesSource implements PersonNamesSource {

    @Override
    public Person[] getPersonNames() {
        return new Person[] {
            new Person("Bazodanowy Jan Kowalski #2"),
            new Person("Bazodanowy Adam Nowak #2")
        };
    }
}
