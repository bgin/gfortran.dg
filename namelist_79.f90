! { dg-do run }
! PR libfortran/52512 - Cannot match namelist object name
! Test case derived from PR.

program testje

    implicit none

    integer :: getal, jn
    type ptracer
        character(len = 8)  :: sname  !: short name
        logical             :: lini   !: read in a file or not
    end type ptracer
    type(ptracer) , dimension(3) :: tracer
    namelist/namtoptrc/  getal,tracer

    ! standard values
    getal = 9999
    do jn = 1, 3
        tracer(jn)%sname = 'default_name'
        tracer(jn)%lini = .false.
    end do

    open (10, status='scratch')
    write (10, '(a)') "&namtoptrc"
    write (10, '(a)') "   getal = 7"
    write (10, '(a)') "   tracer(1) = 'DIC     ', .true."
    write (10, '(a)') "   tracer(2) = 'Alkalini', .true."
    write (10, '(a)') "   tracer(3) = 'O2      ', .true."
    write (10, '(a)') "/"
    rewind(10)
    read(10, nml=namtoptrc)
    close (10)

    if (getal /= 7) stop 1
    if (tracer(1)%sname /= 'DIC     ') stop 1
    if (tracer(2)%sname /= 'Alkalini') stop 1
    if (tracer(3)%sname /= 'O2      ') stop 1
    if (.not. tracer(1)%lini) stop 1
    if (.not. tracer(2)%lini) stop 1
    if (.not. tracer(3)%lini) stop 1

end program testje
