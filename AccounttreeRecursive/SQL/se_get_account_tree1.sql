
alter procedure [dbo].[se_get_account_tree1]--se_get_account_tree1 28
(	@account_id varchar(40)
) 
as
create table #parent_accounts (ID numeric(10) not null,Level numeric(10) not null,Parent_account_id numeric(10) not null,Parent_Account_name varchar(40),child_type varchar(40),
   Child_account_id numeric(10) not null,Child_Account_name varchar(40));
	
begin

 WITH AccountHierarchy AS
(
    SELECT 1 as Level, H1.parent_id, H1.child_id, h1.child_type FROM account_hierarchy H1
    WHERE   parent_id != child_id
          and parent_id=@account_id
    UNION ALL
    SELECT RCTE.level + 1 as Level, H2.parent_id, H2.child_id, h2.child_type FROM account_hierarchy H2
    INNER JOIN AccountHierarchy RCTE ON H2.parent_id = RCTE.child_Id
       and h2.parent_id != h2.child_id
),
acct as
(

select level,parent_id Parent_account_id, parent.short_name Parent_Account_Name, case when child_type=2 then 'Account Group'
                                                        else 'Account'
                                                                                     end child_type, child_id Child_account_id, child.short_name Child_Account_Name    
from AccountHierarchy, account parent, account child
where AccountHierarchy.parent_id=parent.account_id
and AccountHierarchy.child_id=child.account_id
--and AccountHierarchy.parent_id <> @account_id and AccountHierarchy.parent_id != 0
union all
select 0 level, 0 parent_id, Null ,'Account Group', account_id, short_name
from account
where account_id=@account_id 
 )
--select ROW_NUMBER() over(order by level, child_account_id) ID, acct.*
--from acct
select C.* into #tep
from Acct c


SELECT inn.Child_account_id, inn.Parent_account_id,inn.Child_Account_Name,inn.Parent_Account_Name,inn.child_type
FROM
(SELECT t.Parent_account_id, t.Child_account_id, t.Child_Account_Name,t.Parent_Account_Name,t.child_type,
        ROW_NUMBER() OVER(PARTITION BY t.Child_account_id ORDER BY t.Parent_account_id,t.Child_Account_Name,t.Parent_Account_Name,t.child_type) num
 FROM #tep t) inn
 WHERE inn.num=1
order by inn.child_type desc,inn.Child_Account_Name desc

end

select * from account where account_id in (
20462,
20492)