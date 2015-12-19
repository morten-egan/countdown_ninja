create or replace package body countdown_ninja

as

  procedure init (
    countdown_name              in        varchar2
    , start_from                in        number
    , zero_call                 in        varchar2 default null
  )

  as

  begin

    if sys_context('countdown_ninja_c', countdown_name) is null then
      -- We have a non-existent countdown ticker, so we can just initialize
      dbms_session.set_context('countdown_ninja_c', countdown_name, start_from);
      if zero_call is not null then
        dbms_session.set_context('countdown_ninja_c', countdown_name || '_zerocall', zero_call);
      end if;
    end if;

    exception
      when others then
        null;

  end init;

  procedure cd (
    countdown_name             in        varchar2
  )

  as

    l_current_val              number;

  begin

    if sys_context('countdown_ninja_c', countdown_name) is not null then
      l_current_val := to_number(sys_context('countdown_ninja_c', countdown_name)) - 1;
      if l_current_val = 0 then
        if sys_context('countdown_ninja_c', countdown_name || '_zerocall') is not null then
          execute immediate 'begin ' || sys_context('countdown_ninja_c', countdown_name || '_zerocall') || '; end;';
          dbms_session.clear_context(namespace => 'stats_ninja_c', attribute => countdown_name || '_zerocall');
        end if;
        dbms_session.clear_context(namespace => 'stats_ninja_c', attribute => countdown_name);
      else
        dbms_session.set_context('countdown_ninja_c', countdown_name, l_current_val);
      end if;
    end if;

    exception
      when others then
        null;

  end cd;

end countdown_ninja;
/
