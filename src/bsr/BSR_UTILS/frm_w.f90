program frm_w
  use radial
  implicit real(8) (a-h,o-z)
  character(80) :: AF, BF
  integer :: iarg, i, inp, iout, m

  iarg = COMMAND_ARGUMENT_COUNT()
  if(iarg > 0) call GET_COMMAND_ARGUMENT(1, AF)

  if(iarg == 0 .or. AF == '?') then
     write(*,'(/a)') 'frm_w  converts  name.frm  to name.w'
     write(*,'(/a)') 'frm - formatted radial functions'
     write(*,'(/a)') 'w   - unformatted radial functions'
     write(*,'(/a)') 'Call as:  frm_w  name.frm'
     write(*,'(/a)') 'Results:  name.w'
     stop
  end if

  i = index(AF, '.')
  if(i <= 0) stop 'input file should have frm-extension'
  inp = 1
  open(inp, file=AF, status='OLD')

  BF = AF(1:i)//'w'
  iout = 2
  open(iout, file=BF, form='UNFORMATTED')

  call Read_frm(inp)

  do m = 1, nrf
     call RW_w(iout, m, 'w')
  end do

  close(inp)
  close(iout)

end program frm_w
