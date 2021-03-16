
module Comparison
    def compare(x,y)
        x > y ? true : false  #make x node.data, and y other_node.data 
    end 
end



class Node
    include Comparison

    def initialize(data,lc = nil,rc = nil)
        @data = data
        @left_child = lc
        @right_child = rc
        
    end
    def read
        @data
    end
    def left_child
        @left_child
    end
    def set_left_child(value)
        @left_child = value
    end
    def right_child
        @right_child
    end
    def set_right_child(value)
        @right_child = value
    end
    def to_s    
        "   data:#{@data} \n lc:#{@left_child.read if @left_child}  rc: #{@right_child.read if @right_child}"
    end

end

class Tree < Node
    
    def initialize(arr)
        @arr = arr  
        @base_root = nil
    end
    def to_s
        puts "#{@arr.sort!}"
    end
    def build_tree(arr = @arr, node = @base_root)

        arr.sort!.uniq!
        if arr.length == 1 
            #puts node.to_s
            return
        end 
        
        mid = arr.length / 2 
        if @base_root.nil?
            @base_root = Node.new(arr[mid]) 
            node = @base_root
        end 
        left_array = arr[0...mid] 
        right_array = arr[mid + 1...arr.length] if arr[mid + 1] 
        node.set_left_child(Node.new(left_array[(left_array.length / 2)]))
        node.set_right_child(Node.new(right_array[(right_array.length / 2)])) if right_array
        build_tree(left_array, node.left_child)
        build_tree(right_array, node.right_child) if right_array
        
        
       # puts node.to_s 
        node
    end

    def insert(value)
        @arr << value
        @arr.sort!.uniq!
        self.build_tree
    end

    def delete(value)
        if @arr.include?(value)
            @arr -= [value]
            self.build_tree
        else
            puts "The tree does not contain #{value}"
        end
    end

    def find(value, root = self.build_tree)
        if root.read == value 
            
            puts "#{root} contains #{value}"
            return root
        elsif root.read > value
            self.find(value, root.left_child)
        else
            self.find(value, root.right_child)
        end
        

    end

    def level_order(root = @base_root) 
        #should return [6,3,9,2,5,8,10,1,4,7].
        return if root.nil? 
        @queue = [root] unless @queue
        @bfs = [] unless @bfs
        unless @queue.empty?
        @bfs << root.read
        @queue << root.left_child if root.left_child
        @queue << root.right_child if root.right_child
        @queue = @queue[1...@queue.length]
        self.level_order(@queue[0])
        end
       
       @bfs

    end

    def inorder
    end

    def preorder
    end

    def postorder
    end

    def height
    end

    def depth
    end

    def balanced?
    end

    def rebalance
    end


end

tree = Tree.new([1,2,3,4,5,6,7,8,9,10])
tree.build_tree
print tree.level_order
