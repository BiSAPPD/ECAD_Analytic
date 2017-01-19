
select
(Case current_database()
                When 'loreal' then 'LP'
                When 'matrix' then 'MX'
                When 'luxe' then 'KR'
                When 'redken' then 'RD'
                When 'essie' then 'ES'
                End) 

, extract(year from usr.created_at)::int as year
, extract(month from usr.created_at)::int as month
, Count(usr.id) as users
, sum(( Case when usr.email like '%@%' then 1 else 0 end)) as emails
, ((sum(( Case when usr.email like '%@%' then 1 else 0 end))::numeric/ Count(usr.id)::numeric) * 100)::int || '%' as "%"
, sum(( Case when char_length(usr.mobile_number) >8 then 1 else 0 end)) as phone
, ((sum(( Case when char_length(usr.mobile_number) >8 then 1 else 0 end)) ::numeric/ Count(usr.id)::numeric) * 100)::int || '%' as "%"
, sum((Case when usr.last_request_at is not Null Then 1 Else 0 end))::int as act_usrs
, ((sum((Case when usr.last_request_at is not Null Then 1 Else 0 end))::numeric/ Count(usr.id)::numeric) * 100)::int || '%' as "%"

from users as usr

where  usr.created_at is not  Null 

group by year, month 
order by year, month
