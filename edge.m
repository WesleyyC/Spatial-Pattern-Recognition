classdef edge < handle
    %   edge is the connection between node and 
    %   it will have some assigned weight and two end points (nodes)
    
    properties (GetAccess=public,SetAccess=private)
        % The attributes
        weight = NaN;   % the weight for the link, and be NaN if there is no link between node1 and node2
        node1 = NaN;
        node2 = NaN;
    end
    
    methods
        % Constructor for the class
        function  self = edge(weight,node1ID,node2ID,sortedNodes)
            % Throw error if not enough argument
            if nargin < 4
                error "NotEnoughArgument";
            end
            
            % Otherwise, we process the argument
            self.weight = weight;
            
            if ~isnan(weight) % if this is a true link
                self.node1 = sortedNodes{node1ID};
                self.node2 = sortedNodes{node2ID};

                % Adding neighnors
                self.node1.addNeighbor(self.node2);
                self.node2.addNeighbor(self.node1);
                
                % We assign the edges to the new node
                self.node1.addEdge(self);
                self.node2.addEdge(self);
            end
            
        end
        
        % Get the similarity between two edges
        function [c] = compatibility(obj,obj2)
            
            if ~isa(obj2,'edge')% obj2 has to be a node too
                c = NaN;
            else
                c = edge_compatibility(obj,obj2);
            end
        end
        
        function [tf] = trueEdge(obj)
            tf=~isnan(obj.weight);
        end
    end
    
end

