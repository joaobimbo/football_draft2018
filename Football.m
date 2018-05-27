classdef Football < handle
    properties
        doodle
        members
        girls
        n_members
        b_members
        g_members
        nb_per_game
        ng_per_game
        n_girls
        avail_grid
        grid
        games
        players
    end
    methods
        function obj = Football()
            obj.girls={'Veronica Penza','Lucia Schiatti','Lara Soggiu'...
                ,'Francesca Bonavita','Meri Lazzaroni','Lorenza Mancini'};
            obj.nb_per_game=10;
            obj.ng_per_game=4;
            
            obj.doodle=import_doodle('Doodle.xls');
            obj.n_members=size(obj.doodle,1);
            obj.members=[[1:obj.n_members]',obj.doodle(:,1)];
            obj.doodle(:,1)=obj.members(:,1);
            obj.avail_grid=str2double(obj.doodle);
            obj.n_girls=length(obj.girls);
            obj.g_members=[];
            obj.b_members=[];
            obj.games={};
            obj.players={};
            obj.split_b_and_g();
            obj.grid=zeros(obj.n_members,obj.n_members);
            
            
        end
        function split_b_and_g(obj)
            for i=1:obj.n_members
                girl=false;
                for j=1:obj.n_girls
                    if(strcmpi(strtok(obj.members(i,2),' '),strtok(obj.girls{j},' '))==1)
                        obj.g_members=[obj.g_members;obj.avail_grid(i,:)];
                        girl=true;
                    end
                end
                if(~girl)
                    obj.b_members=[obj.b_members;obj.avail_grid(i,:)];
                end
                obj.players{i}=player(double(obj.members(i,1)),obj.members(i,2),girl,obj.avail_grid(i,2:end),obj.n_members);
            end
        end
        function find_cand(obj)
            
        end
        
        function draft(obj,fixture,selection)
           obj.games{fixture}=selection;
           for i=1:length(selection)               
              obj.players{selection(i)}.select_to_play(fixture,selection);
           end
        end
        function erase_game(obj,fixture)
           selection=obj.games{fixture};
           for i=1:length(selection)               
              obj.players{selection(i)}.remove_from_play(fixture,selection);
           end
           obj.games{fixture}=[];
        end
        
        function [c,ng]=cost_of_selection(obj,selection)
            gp=0;
            gr=0;
            pw=0;
            ng=0;
            for i=selection
                gp=gp+length(obj.players{i}.g_played);
                gr=gr+obj.players{i}.rem_games;
                if(obj.players{i}.girl==1) 
                    ng=ng+1;
                end                
                for j=1:length(selection)
                    pw=pw+(obj.players{i}.played_with(obj.players{selection(j)}.id)*2).^2;
                end
            end            
           c=gp*10000+gr*20+pw+abs(ng-obj.ng_per_game)*10;
        end
    end
end