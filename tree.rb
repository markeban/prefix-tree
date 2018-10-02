# Prefix Tree
class Tree
  class InputError < StandardError; end

  attr_reader :letters_map, :root, :root_letter

  def initialize(root = nil, root_letter = nil)
    @root = root
    @root_letter = root_letter
    @letters_map = {}
  end

  def add_word(word)
    add_letters(word.split(//))
  end

  def search_word
    puts 'Enter the first few letters of a word and hit enter'
    input_letters = gets.chomp.split(//)
    end_search_node = search_down(self, input_letters)
    nodes_below = find_nodes_below(end_search_node)
    join_letters(nodes_below)
  rescue InputError => error
    puts error.message
  end

  protected

  def add_letters(letters)
    return @letters_map['complete'] = true if letters.empty?

    first_character = letters.shift
    if @letters_map[first_character]
      return @letters_map[first_character].add_letters(letters)
    end

    new_tree = Tree.new(self, first_character)
    new_tree.add_letters(letters)
    @letters_map[first_character] = new_tree
  end

  def search_down(node, input_letters)
    return node if input_letters.empty?

    first_character = input_letters.shift
    if node.letters_map[first_character]
      return search_down(node.letters_map[first_character], input_letters)
    end

    raise InputError, 'No words match the your input'
  end

  def find_nodes_below(node)
    end_nodes = []
    children = []
    node.letters_map.each do |_letter, tree|
      if tree == true
        end_nodes << node
      else
        children << tree
      end
    end

    end_nodes + children.map { |tree| find_nodes_below(tree) }.flatten
  end

  def join_letters(nodes)
    nodes.map do |node|
      letters = []
      while node.root
        letters.unshift(node.root_letter)
        node = node.root
      end
      letters.join
    end
  end
end

tree = Tree.new
tree.add_word('app')
tree.add_word('application')
tree.add_word('cat')
tree.add_word('carp')
tree.add_word('city')
tree.add_word('dog')
tree.add_word('eagle')
tree.add_word('fish')
tree.add_word('fit')
p tree.search_word
