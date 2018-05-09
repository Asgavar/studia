# -*- coding: utf-8 -*-
# Zastosowany wzorzec to Strategia, wstrzykiwana przez konstruktor.

class SuperCollection
  def initialize(initial_array=nil)
    unless initial_array.nil?
      @inner_array = initial_array
    else
      @inner_array = []
    end
  end

  def length
    @inner_array.length
  end

  def get(i)
    @inner_array[i]
  end

  def put(at_index, what)
    @inner_array[at_index] = what
  end

  def push(element)
    @inner_array.push(element)
  end

  def swap(i, j)
    @inner_array[i], @inner_array[j] = @inner_array[j], @inner_array[i]
  end

  def between_inclusive(left, right)
    SuperCollection.new(@inner_array[left, right])
  end

  def min
    @inner_array.min
  end

  def max
    @inner_array.max
  end

  def to_s
    @inner_array.to_s
  end
end


class SuperSorting
  def initialize(sorting_strategy)
    @sorting_strategy = sorting_strategy
  end

  def sort_collection(collection)
    @sorting_strategy.sort(collection)
  end
end


class BubbleSortStrategy
  def sort(collection)
    collection_length = collection.length
    swapped_in_last_pass = true
    while swapped_in_last_pass
      swapped_in_last_pass = false
      (collection_length - 1).times do |index|
        if collection.get(index) > collection.get(index + 1)
          collection.swap(index, index + 1)
          swapped_in_last_pass = true
        end
      end
    end
  end
end


class SelectionSortStrategy
  def sort(collection)
    unsorted = []
    collection.length.times do |index|
      unsorted.push(collection.get(index))
    end
    unsorted.length.times do |index|
      after_index = unsorted[index, unsorted.length]
      current_minimal = unsorted.min
      collection.put(index, current_minimal)
    end
  end
end


bubblesort = SuperSorting.new(BubbleSortStrategy.new)
selectionsort = SuperSorting.new(SelectionSortStrategy.new)
collection1 = SuperCollection.new
collection2 = SuperCollection.new
collection3 = SuperCollection.new
collection4 = SuperCollection.new

15.times do
  collection1.push(rand(999))
  collection2.push(rand(999))
  collection3.push(rand(999))
  collection4.push(rand(999))
end

puts "Nieposortowana kolekcja pierwsza: #{collection1}"
puts "Nieposortowana kolekcja druga: #{collection2}"
puts "Nieposortowana kolekcja trzecia: #{collection3}"
puts "Nieposortowana kolekcja czwarta: #{collection4}"
puts ''

bubblesort.sort_collection(collection1)
bubblesort.sort_collection(collection2)

puts"Kolekcja pierwsza posortowana bąbelkowo: #{collection1}"
puts"Kolekcja druga posortowana bąbelkowo: #{collection2}"

selectionsort.sort_collection(collection3)
selectionsort.sort_collection(collection4)

puts "Kolekcja trzecia posortowana przez wybór: #{collection3}"
puts "Kolekcja czwarta posortowana przez wybór: #{collection4}"
