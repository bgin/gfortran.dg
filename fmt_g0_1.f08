! { dg-do run }
! PR36420 Fortran 2008: g0 edit descriptor 
! Test case provided by Jerry DeLisle <jvdelisle@gcc.gnu.org>
    character(25) :: string = "(g0,g0,g0)" 
    character(50) :: buffer
    write(buffer, '(g0,g0,g0)') ':',12340,':'
    if (buffer.ne.":12340:") stop 1
    write(buffer, string) ':',0,':'
    if (buffer.ne.":0:") stop 1
    write(buffer, string) ':',1.0_8/3.0_8,':'
    if (buffer.ne.":0.33333333333333331:") stop 1
    write(buffer, '(1x,a,g0,a)') ':',1.0_8/3.0_8,':'
    if (buffer.ne." :0.33333333333333331:") stop 1
    write(buffer, string) ':',"hello",':'
    if (buffer.ne.":hello:") stop 1 
    write(buffer, "(g0,g0,g0,g0)") ':',.true.,.false.,':'
    if (buffer.ne.":TF:") stop 1
    write(buffer, "(g0,g0,',',g0,g0)") '(',( 1.2345_8, 2.4567_8 ),')'
    if (buffer.ne."(1.2344999999999999,2.4567000000000001)") stop 1
end
