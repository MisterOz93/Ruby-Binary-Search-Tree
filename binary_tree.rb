class Node

    def initialize(data,lc = nil,rc = nil)
        @data = data
        @left_child = lc
        @right_child = rc
        
    end
    def read
        @data
    end
    def set_data(value)
        @data = value
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
    def number_of_children
        output = 0
        output += 1 if @left_child
        output += 1 if @right_child
        output
    end
    def delete
        @data = nil
        @left_child = nil
        @right_child = nil
    end
    def parent(node = nil)
        @parent = node if node
        @parent
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
        lc = Node.new(left_array[(left_array.length / 2)])
        rc = Node.new(right_array[(right_array.length / 2)]) if right_array
        lc.parent(node)
        rc.parent(node) if rc
        node.set_left_child(lc)
        node.set_right_child(rc) if rc
        build_tree(left_array, node.left_child)
        build_tree(right_array, node.right_child) if right_array
        
        
       #puts node.to_s 
        node
    end

    def insert(value, existing_node = @base_root)
        if @arr.include? value
            puts "the tree already has a node with #{value}."
            return
        end
       if value > existing_node.read && existing_node.right_child.nil?
            existing_node.set_right_child(Node.new(value))
       elsif value > existing_node.read && existing_node.right_child
            self.insert(value,existing_node.right_child)
       elsif value < existing_node.read && existing_node.left_child.nil?
            existing_node.set_left_child(Node.new(value))
       elsif value < existing_node.read && existing_node.left_child
            self.insert(value, existing_node.left_child)
       end
       #puts existing_node
    end

    def delete(value) 
        node = self.find(value)
        unless node.is_a? Node
            return
        end
       
       if node.number_of_children == 0
            node.delete
            return
       elsif node.number_of_children == 1 && node.left_child
            if node.parent.left_child == node
                node.parent.set_left_child(node.left_child)
            elsif node.parent.right_child == node
                node.parent.set_right_child(node.left_child)
            end
            node.delete   
       elsif node.number_of_children == 1 && node.right_child
            if node.parent.left_child == node
                node.parent.set_left_child(node.right_child)
            elsif node.parent.right_child == node
                node.parent.set_right_child(node.right_child)
            end
            node.delete    
       else 
            replacement = node.right_child
            while replacement.left_child
                replacement = replacement.left_child 
            end
                node.set_data(replacement.read)
                replacement.delete
        end

    end

    def find(value, node = @base_root)
        unless node.is_a? Node
            puts "Could not find #{value}"
            return
        end
        if value
        if node.read == value 
            return node
        elsif node.read > value
            self.find(value, node.left_child)
        elsif node.read < value
            self.find(value, node.right_child)
        end
    end
        

    end

    def level_order(root = @base_root) 
        #should return [6,3,9,2,5,8,10,1,4,7].
        if data.read.nil?
            return
        end
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

    def inorder(data = @base_root) #left -> root -> right
        if data.read.nil?
            return
        end
        @inorder_list = [] unless @inorder_list
        if data.left_child
            inorder(data.left_child)
        end
        @inorder_list << data.read
        if data.right_child
            inorder(data.right_child)
        end
        @inorder_list

    end

    def preorder(data = @base_root) # root -> left -> right
        if data.read.nil?
            return
        end
        @preorder_list = [] unless @preorder_list
        @preorder_list << data.read
        if data.left_child
            preorder(data.left_child)
        end
        if data.right_child
            preorder(data.right_child)
        end
        @preorder_list
    end

    def postorder(data = @base_root) # left -> right -> root
        if data.read.nil?
            return
        end
        @postorder_list = [] unless @postorder_list
        if data.left_child
            postorder(data.left_child)
        end
        if data.right_child
            postorder(data.right_child)
        end
        @postorder_list << data.read
        @postorder_list

    end

    def height(node_value) #node to furthest leaf
        node = self.find(node_value)    
        @height = 0 unless @height
        @height = 0 if @reset == 1
        if node
        unless node.left_child || node.right_child
            @reset = 0
            return @height if @height == 0
        end
        if node.left_child && node.right_child.nil?
            @reset = 0
            @height += 1
            self.height(node.left_child.read) 
        end
        if node.right_child && node.left_child.nil?
            @reset = 0
            @height += 1
            self.height(node.right_child.read)
        end
        if node.right_child && node.left_child
            @reset = 0
            @height += 1
            rc = node.right_child
            lc = node.left_child
            if lc.number_of_children > rc.number_of_children
                self.height(lc.read)
            else
                self.height(rc.read)
            end
        end
        end
        @reset = 1
        @height
    end

    def depth(node_value) #node to root
        @depth = 0 
        target_node = self.find(node_value)
        starting_node = @base_root
        until starting_node == target_node
            if starting_node.read > target_node.read
                @depth += 1
                starting_node = starting_node.left_child
            elsif
                starting_node.read < target_node.read
                @depth += 1
                starting_node = starting_node.right_child
            end
        end
        @depth
        
    end

    def balanced?(node = @base_root)
        left_height = 0
        right_height = 0
        if node.left_child
            while node.left_child
                node = node.left_child
                left_height += 1
            end
        end
        if node.right_child
            while node.right_child
                node = node.right_child
                right_height += 1
            end
        end
        #lets say lh is 3 and rh is 1
        if left_height - right_height > 1 || right_height - left_height > 1
            return nil
        else
            return true
        end
        
    end

    def rebalance #rebalance if the tree is unbalanced. read every node into a new array, then build new tree
        unless self.balanced?
            @inorder_list = []
            self.inorder
            @base_root = nil
            self.build_tree(@inorder_list)
            @inorder_list = nil
        end
    end


end

tree = Tree.new([1,2,3,4,5,6,7,8,9,10])
tree.build_tree
#print tree.find(6)
tree.delete(9)
#print tree.find(4)
#print tree.inorder
#print tree.postorder
#print tree.preorder
#print tree.level_order
#print tree.height(6)
#print tree.height(10)
#print tree.depth(1)
#print tree.balanced?
tree.rebalance

