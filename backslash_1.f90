! { dg-do run }
      character(len=4) a
      open (10, status='scratch')
      write (10,'(A)') '1\n2'
      rewind (10)
      read (10,'(A)') a
      if (a /= '1\n2') stop 1
      end
