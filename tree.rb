class Tree

  attr_reader :letters_map, :root, :root_letter

  def initialize(root = nil, root_letter = nil)
    @root = root
    @root_letter = root_letter
    @letters_map = {}
  end

  def add_word(word)
    add_letters(word.split(//))
  end

  def add_letters(letters)
    return @letters_map['complete'] = true if letters.empty?

    first_character = letters.shift
    if @letters_map[first_character]
      @letters_map[first_character].add_letters(letters)
    else
      new_tree = Tree.new(self, first_character)
      new_tree.add_letters(letters)
      @letters_map[first_character] = new_tree
    end
  end

  def search_word
    # input = gets.chomp
    # input_letters = input.split(//)
    input_letters = ["c", "a"]
    end_search_node = search_down(self, input_letters)
    nodes_below = find_nodes_below(end_search_node)
    join_letters(nodes_below)
  end

  def search_down(node, input_letters)
    if input_letters.any?
      first_character = input_letters.shift
      search_down(node.letters_map[first_character], input_letters) if node.letters_map[first_character]
    else
      node
    end
  end

  def find_nodes_below(node)
    end_nodes = []
    deeper_end_nodes = []
    node.letters_map.each do |_letter, tree|
      if tree == true
        puts "this is an endnode. node: #{node.root_letter}"
        end_nodes << node
        puts "end_nodes just added: #{end_nodes.map(&:root_letter)}"
      else
        puts "about to recursively check child #{tree.root_letter}"
        deeper_end_nodes = find_nodes_below(tree)
        puts "deeper_end_nodes from recursion: #{deeper_end_nodes.map(&:root_letter)}"
      end
    end
    puts "end_nodes before returning: #{end_nodes.map(&:root_letter)}"
    puts "deeper_end_nodes before returning: #{deeper_end_nodes.map(&:root_letter)}"
    end_nodes + deeper_end_nodes
  end

  def join_letters(nodes_below)
    nodes_below.map do |node|
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
tree.add_word("cat")
tree.add_word("carp")
tree.add_word("city")
tree.add_word("dog")
tree.add_word("eagle")
tree.add_word("fish")
tree.add_word("fit")
p tree.search_word
require 'pry'; binding.pry
# require 'pry'; binding.pry
