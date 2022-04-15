//
// Created by Элина Болдова on 29.11.2021.
//

#ifndef UNTITLED6_DOUBLYLINKLIST_H
#define UNTITLED6_DOUBLYLINKLIST_H

#include <iostream>
using namespace std;

template<typename T>
class DoublyLinkList
{

private:

    // Структура, которая реализует узел списка
    struct Node
    {
        T _data;	// Содержимое узла
        Node* prev;	// Указатель на предыдущий узел
        Node* next;	// Указатель на следующий узел
    };

    Node* _first;	// Указатель на первый узел списка
    Node* _last;	// Указатель на последний узел списка
    int _size;		// Размер списка

    // Перечисление, используемое в приватном методе ниже
    enum {
        up = 0,
        down = 1,
    };

    // Метод, исключающий дублирование кода при поиске элементов внутри класса
    Node& findNode(int n, int way = -1) const;


public:

    // Конструктор по умолчанию
    DoublyLinkList();
    // Конструктор с созданием одного узла
    DoublyLinkList(T);
    // Конструктор копирования (глубокое копирование)
    DoublyLinkList(const DoublyLinkList&);

    // Деструктор
    ~DoublyLinkList();

    // Добавление узла в конец списка
    DoublyLinkList& add(const T&);
    // Добавление узла на указанную позицию
    DoublyLinkList& add(const T&, int n);

    // Размещение указанного количества элементов массива в конец списка
    DoublyLinkList& add(const T[], int number);
    // То же, что и выше, только с указанием позиции размещения
    DoublyLinkList& add(const T[], int number, int n);

    // Добавление узлов из другого списка
    DoublyLinkList& add(const DoublyLinkList<T>&);
    // То же, только с добавлением на указанную позицию
    DoublyLinkList& add(const DoublyLinkList<T>&, int n);

// Удаление узлов, начиная с узла, который указан в n 
// (по умолчанию удаляется один узел)
    DoublyLinkList& Delete(int n, int range = 1);
    // Удаление узла в конце списка
    DoublyLinkList& Delete();

// Перегрузка операции [], используется при использование 
    T operator[](int i) const;
    // То же, только используется в изменяемом списке
    T& operator[](int i);

    // Перегрузка оператора сложения
    DoublyLinkList operator+(const DoublyLinkList<T>&) const;
    // Перегрузка операции равно (глубокое копирование)
    const DoublyLinkList& operator=(const DoublyLinkList<T>&);

    // Метод, возвращающий размер списка
    int Size();
    void show();
};


#endif //UNTITLED6_DOUBLYLINKLIST_H
