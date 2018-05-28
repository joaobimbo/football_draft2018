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
        function obj = Football(in_file)
            obj.girls={'Veronica Penza','Lucia Schiatti','Lara Soggiu'...
                ,'Francesca Bonavita','Meri Lazzaroni','Lorenza Mancini'};
            obj.nb_per_game=10;
            obj.ng_per_game=4;
            
            obj.doodle=import_doodle(in_file);
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
        
        function valid=is_valid(obj,fixture,selection)
            valid=(sum(obj.avail_grid(selection,fixture+1))==length(selection));
        end
        function add_to_selection(obj,fixture,in)
            selection=obj.games{fixture};
            [~,idx2]=find(selection==in);
            if(~isempty(idx2))
                error('Player already selected for this match');
            end
            selection(end+1)=in;
            if(obj.is_valid(fixture,in))
                obj.erase_game(fixture);
                obj.draft(fixture,selection)
            else
                error('Player is not available for this match');
            end
        end
        
        function switch_player(obj,fixture,out,in)
            selection=obj.games{fixture};
            [~,idx]=find(selection==out);
            [~,idx2]=find(selection==in);
            if(isempty(idx))
                error('Player was not selected for this match');
            end
            if(~isempty(idx2))
                error('Player already selected for this match');
            end
            
            selection(idx)=in;
            if(obj.is_valid(fixture,selection))
                obj.erase_game(fixture)
                obj.draft(fixture,selection)
            end
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
            
            gp_n=zeros(1,length(selection));
            for i=1:length(selection)
                gp_n(i)=length(obj.players{selection(i)}.g_played);
            end
            
            c=gp*1000+gr*20+pw+abs(ng-obj.ng_per_game)*10+1000*mean(gp_n)+100*std(gp_n);
        end
    end
end