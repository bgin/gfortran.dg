! { dg-do run }
!  Short test program with a CASE statement that uses a range.
!
program select_4
  integer i
  do i = 1, 34, 4
     select case(i)
     case (:5)
       if (i /= 1 .and. i /= 5) stop 1
     case (13:21)
       if (i /= 13 .and. i /= 17 .and. i /= 21) stop 1
     case (29:)
       if (i /= 29 .and. i /= 33) stop 1
     case default
       if (i /= 9 .and. i /= 25) stop 1
     end select
  end do
end program select_4
