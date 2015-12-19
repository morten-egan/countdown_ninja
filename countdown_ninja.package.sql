create or replace package countdown_ninja

as

  /** A simple package to handle a countdown across sessions, for the entire instance.
  * @author Morten Egan
  * @version 0.0.1
  * @project COUNTDOWN_NINJA
  */
  npg_version         varchar2(250) := '0.0.1';

  /** Initiate a countdown ticker
  * @author Morten Egan
  * @param countdown_name The name of the countdown ticker
  * @param start_from The value to start the countdown from
  * @param zero_call When counter reaches zero, call this procedure.
  */
  procedure init (
    countdown_name              in        varchar2
    , start_from                in        number
    , zero_call                 in        varchar2 default null
  );

  /** Countdown the ticker
  * @author Morten Egan
  * @param countdown_name The name of the ticker to decrement.
  */
  procedure cd (
    countdown_name             in        varchar2
  );

end countdown_ninja;
/
