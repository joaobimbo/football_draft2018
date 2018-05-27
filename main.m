clear
rng('shuffle');
f=Football;


tic
for j=1:10
    c_min=1e9;
    j
    for i=1:5000
        avails=f.avail_grid(find(f.avail_grid(:,j+1)==1),1);
        ss=randperm(length(avails),9);
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