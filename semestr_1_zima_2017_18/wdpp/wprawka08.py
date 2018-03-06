#!/usr/bin/env python3.6

import statistics
from collections import defaultdict
from os import path

class Student:
    def __init__(self, name):
        self.name = name
        self.student_marks = defaultdict(lambda: [])

    def __str__(self):
        return self.name

    def add_marks(self, course_name, marks):
        # print(course_name, marks)
        marks = ''.join(marks).split(',')
        self.student_marks[course_name].extend([int(m) for m in marks])

    def generate_diploma(self):
        print(
            '---------------------------'
            f'Świadectwo ucznia: {self.name}'
            '---------------------------'
        )
        avgs = []
        for course in self.student_marks.keys():
            course_avg = statistics.mean(self.student_marks[course])
            print(
                f'{course}: '
                f'{round(course_avg)} '
                f'{course_avg}'
            )
            avgs.append(course_avg)
        total_avg = statistics.mean(avgs)
        print(f'Średnia końcowa: {round(total_avg)} {total_avg}')
        return total_avg


if __name__ == '__main__':
    with open(path.expanduser('~/Dropbox/studia/wdpp/oceny.txt')) as infile:
        marks = infile.readlines()
    student_list = []
    for line in marks:
        if line == '\n':
            continue
        if ':' in line:
            course_name = line[11:-1]  # bez 'przedmiot: ' na poczatku
            continue
        mark_str = line.split()
        name = mark_str[0]
        if name not in [st.name for st in student_list]:
            new_student = Student(name)
            student_list.append(new_student)
        proper_student = list(filter(lambda st: st.name == name, student_list))[0]
        proper_student.add_marks(course_name, mark_str[1:])
    ranking = []
    for student in student_list:
        stud_score = student.generate_diploma()
        ranking.append((student.name, stud_score))
    print(f'\n{"-"*15}RANKING{"-"*15}')
    print(sorted(ranking, key=lambda x: x[1], reverse=True))
