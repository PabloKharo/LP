import sys
from gedcom.parser import Parser
from gedcom.element.individual import IndividualElement

def get_name(person):
    (first, last) = person.get_name()
    if(last != ""):
        return "\'" + first + " " + last + "\'"
    return "\'" + first + "\'"

def add_gender(person, males, females):
    gender = person.get_gender()
    if(gender == "M"):
        males.append("male(" + get_name(person) + ").")
    elif(gender == "F"):    
        females.append("female(" + get_name(person) + ").")

def write_in_file(file_to_write, childs, males, females):
    with open(file_to_write, 'w') as fres:
        for child in childs:
            fres.write(child + '\n')
        for male in males:
            fres.write(male + '\n')
        for female in females:
            fres.write(female + '\n')
    
def main():
    childs = []
    males = []
    females = []

    gedcom_parser = Parser()
    gedcom_parser.parse_file(sys.argv[1], False)
    root_child_elements = gedcom_parser.get_root_child_elements() 
    
    for person in root_child_elements:
        if isinstance(person, IndividualElement):
            add_gender(person, males, females)    
            if(person.is_child()):
                for parent in gedcom_parser.get_parents(person, "ALL"):
                    childs.append("child(" + get_name(person) + ", " + get_name(parent) + ").")

    if(len(sys.argv) == 3):
        write_in_file(sys.argv[2], childs, males, females)
    

main()