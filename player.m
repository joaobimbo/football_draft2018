classdef player < handle
    
    properties
        id
        name
        g_played
        g_available
        n_available
        rem_games
        girl
        played_with
    end
    
    methods
        function obj = player(id,name,girl,avail,n_players)
            %PLAYER Construct an instance of this class
            %   Detailed explanation goes here
            obj.id=id;
            obj.name=name;
            obj.girl=girl;
            obj.g_available=avail;
            obj.n_available=sum(obj.g_available);
            obj.played_with=zeros(1,n_players);
            obj.rem_games=obj.remaining_games(1);
        end
        
        function n = remaining_games(obj,fixture)
            %How many games can this player still play?
            n=sum(obj.g_available(fixture:end));
        end
        
        function av=is_avail(obj,fixture)
            av=obj.g_available(fixture);
        end
        
        function id=select_to_play(obj,fixture,players)
            obj.g_played(end+1)=fixture;
            id=double(obj.id);
            obj.rem_games=obj.rem_games-1;
            
            for i=1:length(players)
                obj.played_with(players(i))=obj.played_with(players(i))+1;
                %if(players(i)==id)
                %    error('Player already selected for this match');
                %end
            end
        end
        function id=remove_from_play(obj,fixture,players)
             obj.g_played(end+1)=fixture;
            id=double(obj.id);
            obj.rem_games=obj.rem_games+1;
            [~,idx2]=find(obj.g_played==fixture);
            obj.g_played(idx2)=[];            
            for i=1:length(players)
                obj.played_with(players(i))=obj.played_with(players(i))-1;
                %if(players(i)==id)
                %    error('Player already selected for this match');
                %end
            end            
        end
        
        function id=remove_from_play2(obj,fixture,foo)
            id=double(obj.id);
            players=foo.games{fixture};
            [~,idx]=find(players==id);
            if(isempty(idx))
                disp('Player was not drafted for this game')
               return 
            end
            [~,idx2]=find(obj.g_played==fixture);
            obj.g_played(idx2)=[];
            for i=1:length(players)
                obj.played_with(players(i))=obj.played_with(players(i))-1;
                foo.players{players(i)}.played_with(id)=foo.players{players(i)}.played_with(id)-1;                
            end
            obj.played_with(id)=obj.played_with(id)+1; %compensate double removal
            foo.games{fixture}(idx)=[];
            obj.rem_games=obj.rem_games+1;
        end
        
        
    end
end