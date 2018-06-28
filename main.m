clear
rng('shuffle');
f=Football('Doodle.xls');
f.draft(1,[1,2,3,6,8,9,10,15,16,18,21,23])
f.draft(2,[1,4,5,7,9,10,11,12,15,16,19,20,21,23])
f.draft(3,[2,3,4,6,8,11,12,15,16,19,23,25])
f.draft(4,[1,3,6,7,9,10,12,14,18,22,24,25]) 
f.draft(5,[1,3,5,6,7,9,10,11,13,20,22]) %plus mohammad
f.draft(6,[1,3,4,6,9,10,11,12,14,17,20,21,22,24]) 
f.draft(7,[2,3,5,6,8,9,10,11,13,19,20,22]) %plus mohammad alp

f.nb_per_game=9;
f.ng_per_game=4;


tic
%%
for j=9:9
    c_min=1e9;
    j
    for i=1:1000
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