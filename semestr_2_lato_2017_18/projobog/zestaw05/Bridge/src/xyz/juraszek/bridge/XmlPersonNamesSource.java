package xyz.juraszek.bridge;

public class XmlPersonNamesSource implements PersonNamesSource {

    @Override
    public Person[] getPersonNames() {
        return new Person[] {
            new Person("XML-owy Jan Kowalski #2"),
            new Person("XML-owy Jan Nowak #2")
        };
    }

}
