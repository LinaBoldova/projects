//
// Created by Элина Болдова on 29.11.2021.
//
#include "DoublyLinkList.h"

//конструктор по умолчанию для нулевого списка
template<typename T>
DoublyLinkList<T>::DoublyLinkList()
{
    _first = nullptr;
    _last = nullptr;
    _size = 0;
}


/*конструктор для списка из одной ячейки со значением _data
 * и нулевыми указателями на предыдущую и следующую ячейку */
template<typename T>
DoublyLinkList<T>::DoublyLinkList(T data)
{
    _size = 1;
    _first = new DoublyLinkList<T>::Node;
    _first->prev = nullptr;
    _first->next = nullptr;
    _first->_data = data;
    //начало и конец списка совпадают
    _last = _first;
}


//конструктор копирования
template<typename T>
DoublyLinkList<T>::DoublyLinkList(const DoublyLinkList<T>& other)
{

    // Для начала установим указатели в "0"
    // на случай, если будет совершена попытка инициализировать
    // созданный объект пустым списком
    _first = nullptr;
    _last = nullptr;
    _size = 0;

    // Просто вызываем метод добавления элемента,
    // который внутри себя выставит все нужные поля объекта
    for (int i = 0; i < other._size; i++)
    {
        Add(other[i], i);
    }
}


//метод для поиска указателя temp на ячейку с указанной позицией
template<typename T>
typename DoublyLinkList<T>::Node& DoublyLinkList<T>::findNode(int n, int way) const {
    //указатель для искомой ячейки
    DoublyLinkList<T>::Node *temp;
    /*смещение происходит в зависимости от того, какая ячейка ближе:
     первая или последняя*/
    if (way == -1) {
        if (n > _size / 2) {
            temp = _last;
            for (int i = _size; i > n + 1; i--)
                temp = temp->prev;
        } else {
            temp = _first;
            for (int i = 1; i < n; i++)
                temp = temp->next;
        }
    }
    return *temp;
}


//метод для добавления ячейки в указанную позицию
template<typename T>
DoublyLinkList<T>& DoublyLinkList<T>::add(const T& data, int n)
{
    /*выделяем память для новой ячейки и создаем для нее указатель, записывая данные */
    auto* temp = new DoublyLinkList<T>::Node;
    temp->_data = data;

    //поверяем длину списка
    //при пустом списке добавляется единственный элемент:
    if (_size == 0) {
        _first = temp;
        _first->prev = nullptr;
        _first->next = nullptr;
        _last = _first;
    }
    else {
        //определяем ориентацию позиции относительно размеров имеющегося списка

        //размещение вначале списка:
        /*если указанная позиция равна отрицательному значению, то данная ячейка
         * размещается на крайней позиции слева, то есть становится первой*/
        if (n <= 1){
            temp->prev = nullptr;
            temp->next = &findNode(1);
            (temp->next)->prev = temp;
            _first = temp;
        }
        //размещение вконце списка:
        /*если указанная позиция больше длины списка, то данная ячейка
        * размещается на крайней позиции справа, то есть становится последней*/
        else if (n > _size){
            temp->next = nullptr;
            temp->prev = &findNode(_size);
            temp->prev->next = temp;
            _last = temp;
        }
        //размещение между элементами списка:
        else {
            temp->prev = &findNode(n - 1);
            temp->prev->next = temp;
            temp->next = &findNode(n);
            (temp->next)->prev = temp;
        }
    }
    _size++;
    return *this;
}


template<typename T>
void DoublyLinkList<T>::show()
{
    if (!_first){
        cout << "{}" << endl;
    }
    else {
        typename DoublyLinkList<T>::Node* temp = _first;
        cout << "{";
        for (int i = 1; i < _size; i++) {
            cout << temp->_data << " ;";
            temp = temp->_next;
        }
        cout << temp->_data << "}";
    }
}

template<typename T>
DoublyLinkList<T>& DoublyLinkList<T>::add(const T& data)
{
    return add(data, _size + 1);
}