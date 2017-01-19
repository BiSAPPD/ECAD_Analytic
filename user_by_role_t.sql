
select
(Case current_database()
                When 'loreal' then 'LP'
                When 'matrix' then 'MX'
                When 'luxe' then 'KR'
                When 'redken' then 'RD'
                When 'essie' then 'ES'
                End) 


, Count(usr.id) as users
, sum(( Case when usr.email like '%@%' then 1 else 0 end)) as emails
, ((sum(( Case when usr.email like '%@%' then 1 else 0 end))::numeric/ Count(usr.id)::numeric) * 100)::int || '%' as "%"
, sum(( Case when char_length(usr.mobile_number) >8 then 1 else 0 end)) as phone
, ((sum(( Case when char_length(usr.mobile_number) >8 then 1 else 0 end)) ::numeric/ Count(usr.id)::numeric) * 100)::int || '%' as "%"
, sum((Case when usr.last_request_at is not Null Then 1 Else 0 end))::int as act_usrs
, ((sum((Case when usr.last_request_at is not Null Then 1 Else 0 end))::numeric/ Count(usr.id)::numeric) * 100)::int || '%' as "%"
, (case  when usr.role like  'salon_manager' then 'salon_manager' 
	 when usr.role in ('technolog', 'studio_manager' , 'studio_administrator', 'admin') then 'educater' 
	 when usr.role in('representative', 'cs', 'dr', 'supervisor') then 'commercial'	
	 else 'master'
	end) as roleX
,usr.role
from users as usr

where  usr.created_at is not  Null 

group by roleX, role
order by roleX
