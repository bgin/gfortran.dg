! { dg-do run }
! { dg-options "-fbackslash" }

  character(kind=1, len=3) :: s1
  character(kind=4, len=3) :: s4
  integer :: i

  s1 = "fo "
  s4 = 4_"fo "
  i = 3

  ! Check the REPEAT intrinsic

  if (repeat (1_"foo", 2) /= 1_"foofoo") stop 1
  if (repeat (1_"fo ", 2) /= 1_"fo fo ") stop 1
  if (repeat (1_"fo ", 2) /= 1_"fo fo") stop 1
  if (repeat (1_"fo ", 0) /= 1_"") stop 1
  if (repeat (s1, 2) /= 1_"fo fo ") stop 1
  if (repeat (s1, 2) /= 1_"fo fo") stop 1
  if (repeat (s1, 2) /= s1 // s1) stop 1
  if (repeat (s1, 3) /= s1 // s1 // s1) stop 1
  if (repeat (s1, 1) /= s1) stop 1
  if (repeat (s1, 0) /= "") stop 1

  if (repeat (4_"foo", 2) /= 4_"foofoo") stop 1
  if (repeat (4_"fo ", 2) /= 4_"fo fo ") stop 1
  if (repeat (4_"fo ", 2) /= 4_"fo fo") stop 1
  if (repeat (4_"fo ", 0) /= 4_"") stop 1
  if (repeat (s4, 2) /= 4_"fo fo ") stop 1
  if (repeat (s4, 2) /= 4_"fo fo") stop 1
  if (repeat (s4, 3) /= s4 // s4 // s4) stop 1
  if (repeat (s4, 1) /= s4) stop 1
  if (repeat (s4, 0) /= 4_"") stop 1

  call check_repeat (s1, s4)
  call check_repeat ("", 4_"")
  call check_repeat ("truc", 4_"truc")
  call check_repeat ("truc ", 4_"truc ")

  ! Check NEW_LINE

  if (ichar(new_line ("")) /= 10) stop 1
  if (len(new_line ("")) /= 1) stop 1
  if (ichar(new_line (s1)) /= 10) stop 1
  if (len(new_line (s1)) /= 1) stop 1
  if (ichar(new_line (["",""])) /= 10) stop 1
  if (len(new_line (["",""])) /= 1) stop 1
  if (ichar(new_line ([s1,s1])) /= 10) stop 1
  if (len(new_line ([s1,s1])) /= 1) stop 1

  if (ichar(new_line (4_"")) /= 10) stop 1
  if (len(new_line (4_"")) /= 1) stop 1
  if (ichar(new_line (s4)) /= 10) stop 1
  if (len(new_line (s4)) /= 1) stop 1
  if (ichar(new_line ([4_"",4_""])) /= 10) stop 1
  if (len(new_line ([4_"",4_""])) /= 1) stop 1
  if (ichar(new_line ([s4,s4])) /= 10) stop 1
  if (len(new_line ([s4,s4])) /= 1) stop 1

  ! Check SIZEOF

  if (sizeof ("") /= 0) stop 1
  if (sizeof (4_"") /= 0) stop 1
  if (sizeof ("x") /= 1) stop 1
  if (sizeof ("\xFF") /= 1) stop 1
  if (sizeof (4_"x") /= 4) stop 1
  if (sizeof (4_"\UFFFFFFFF") /= 4) stop 1
  if (sizeof (s1) /= 3) stop 1
  if (sizeof (s4) /= 12) stop 1

  if (sizeof (["a", "x", "z"]) / sizeof ("a") /= 3) stop 1
  if (sizeof ([4_"a", 4_"x", 4_"z"]) / sizeof (4_"a") /= 3) stop 1

  call check_sizeof ("", 4_"", 0)
  call check_sizeof ("x", 4_"x", 1)
  call check_sizeof ("\xFF", 4_"\UFEBCE19E", 1)
  call check_sizeof ("\xFF ", 4_"\UFEBCE19E ", 2)
  call check_sizeof (s1, s4, 3)

contains

  subroutine check_repeat (s1, s4)
    character(kind=1, len=*), intent(in) :: s1
    character(kind=4, len=*), intent(in) :: s4
    integer :: i

    do i = 0, 10
      if (len (repeat(s1, i)) /= i * len(s1)) stop 1
      if (len (repeat(s4, i)) /= i * len(s4)) stop 1

      if (len_trim (repeat(s1, i)) &
          /= max(0, (i - 1) * len(s1) + len_trim (s1))) stop 1
      if (len_trim (repeat(s4, i)) &
          /= max(0, (i - 1) * len(s4) + len_trim (s4))) stop 1
    end do
  end subroutine check_repeat

  subroutine check_sizeof (s1, s4, i)
    character(kind=1, len=*), intent(in) :: s1
    character(kind=4, len=*), intent(in) :: s4
    character(kind=4, len=len(s4)) :: t4
    integer, intent(in) :: i
    
    if (sizeof (s1) /= i) stop 1
    if (sizeof (s4) / sizeof (4_" ") /= i) stop 1
    if (sizeof (t4) / sizeof (4_" ") /= i) stop 1
  end subroutine check_sizeof

end
