c { dg-do run }
      program fool

      real     foo
      integer  n
      logical  t

      foo = 2.5
      n = 5

      t = (n > foo)
      if (t .neqv. .true.) stop 1
      t = (n >= foo)
      if (t .neqv. .true.) stop 1
      t = (n < foo)
      if (t .neqv. .false.) stop 1
      t = (n <= 5)
      if (t .neqv. .true.) stop 1
      t = (n >= 5 )
      if (t .neqv. .true.) stop 1
      t = (n == 5)
      if (t .neqv. .true.) stop 1
      t = (n /= 5)
      if (t .neqv. .false.) stop 1
      t = (n /= foo)
      if (t .neqv. .true.) stop 1
      t = (n == foo)
      if (t .neqv. .false.) stop 1

      end
