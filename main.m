clear
rng('shuffle');
f=Football('Doodle.xls');
f.nb_per_game=9;
f.ng_per_game=4;
f.draft(1,[1,2,3,6,9,10,11,14,16,17,19,22,24])
f.draft(2,[4,5,6,7,10,12,13,16,17,18,20,21])

tic
for j=3:10
    c_min=1e9;
    j
    for i=1:5000
        avails=f.avail_grid(find(f.avail_grid(:,j+1)==1),1);
        ss=randperm(length(avails),f.nb_per_game+f.ng_per_game);
        s=avails(ss)';
        
        %         good=false;
        %         while(~good)
        %             s=randperm(f.n_members,7);
        %             avail=true;
        %             for k=1:length(s)
        %                 if(~f.players{s(k)}.is_avail(j))
        %                     avail=false;
        %                 end
        %             end
        %             if(avail)
        %                 good=true;
        %             end
        %         end
        %
        %s=randperm(f.n_members,f.nb_per_game+f.ng_per_game);
        cs=f.cost_of_selection(s);
        if(cs<c_min)
            c_min=cs;
            bs=s;
        end
    end
    f.draft(j,bs)
end
toc
M=analyse(f);