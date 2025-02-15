MODULE numerical_utilities
use num_types
implicit none
private
public equal
! Overloaded procedure for comparing real types
   INTERFACE equal
      MODULE PROCEDURE equal_scalar , &
                       equal_rank1,  &
                       equal_rank2,  &
                       equal_rank3,  &
                       equal_rank1_rank0, &
                       equal_rank2_rank0, &
                       equal_rank2_real_int, &
                       equal_rank1_real_int, &
                       equal_scalar_real_int, &
                       equal_scalar_int_int

   END INTERFACE

CONTAINS
  !!<summary>This function takes two real entities and compares them
  !! to see if they are equal within some tolerance. This prevents
  !! failed comparisons due to numbers that are "equal" but differ due
  !! to small differences arising from finite precision.</summary>
  !!<parameter name="a" regular="true">The first array to be
  !!compared.</parameter>
  !!<parameter name="b" regular="true">The second array to be
  !!compared.</parameter>
  !!<parameter name="rtolerance" regular="true">The relative tolerance for their comparison
  !! which is multiplied to the larger of a and b.</parameter>
  !!<parameter name="atolerance_" regular="true">The optional absolute
  !!tolerance for their comparison. Is added to the relative tolerance.
  !!Default value is 5E-4</parameter>
  function equal_rank1(a, b, rtolerance, atolerance_)
    logical :: equal_rank1
    real(dp) :: a(:), b(:), rtolerance
    real(dp) :: atolerance
    real(dp), OPTIONAL :: atolerance_
    if(present(atolerance_)) then; atolerance = atolerance_; else; atolerance = 5E-4_dp; endif

    equal_rank1 = .false.
    if(all(abs(a-b) == 0.0)) then
       equal_rank1 = .true. !This line was added so that if a user did
    !request a comparison with a tolerance of zero it would return the
    !correct result, or if the values are actually zero. We added this
    !line instead of making the following one <= so that the codes
    !original functionality would be unaltered.
    else if(all(abs(a - b) < atolerance + rtolerance * max(maxval(abs(a)),maxval(abs(b))))) then
       equal_rank1 = .true.
    end if
  end function equal_rank1

  !!<summary>This function takes two real entities and compares them
  !! to see if they are equal within some tolerance. This prevents
  !! failed comparisons due to numbers that are "equal" but differ due
  !! to small differences arising from finite precision.</summary>
  !!<parameter name="a" regular="true">The first array to be
  !!compared.</parameter>
  !!<parameter name="b" regular="true">The second array to be
  !!compared.</parameter>
  !!<parameter name="rtolerance" regular="true">The relative tolerance for their comparison
  !! which is multiplied to the larger of a and b.</parameter>
  !!<parameter name="atolerance_" regular="true">The optional absolute
  !!tolerance for their comparison. Is added to the relative tolerance.
  !!Default value is 5E-4</parameter>
  function equal_rank2(a, b, rtolerance, atolerance_)
    logical :: equal_rank2
    real(dp) :: a(:,:), b(:,:), rtolerance
    real(dp) :: atolerance
    real(dp), OPTIONAL :: atolerance_
    if(present(atolerance_)) then; atolerance = atolerance_; else; atolerance = 5E-4_dp; endif

    equal_rank2 = .false.
    if(all(abs(a-b) == 0.0)) then
       equal_rank2 = .true. !This line was added so that if a user did
    !request a comparison with a tolerance of zero it would return the
    !correct result, or if the values are actually zero. We added this
    !line instead of making the following one <= so that the codes
    !original functionallity would be unaltered.
    else if(all(abs(a - b) < atolerance + rtolerance * max(maxval(abs(a)),maxval(abs(b))))) then
       equal_rank2 = .true.
    end if
  end function equal_rank2

  !!<summary>This function takes two real entities and compares them
  !! to see if they are equal within some tolerance. This prevents
  !! failed comparisons due to numbers that are "equal" but differ due
  !! to small differences arising from finite precision.</summary>
  !!<parameter name="a" regular="true">The first array to be
  !!compared.</parameter>
  !!<parameter name="b" regular="true">The second array to be
  !!compared.</parameter>
  !!<parameter name="rtolerance" regular="true">The relative tolerance for their comparison
  !! which is multiplied to the larger of a and b.</parameter>
  !!<parameter name="atolerance_" regular="true">The optional absolute
  !!tolerance for their comparison. Is added to the relative tolerance.
  !!Default value is 5E-4</parameter>
  function equal_rank3(a, b, rtolerance, atolerance_)
    logical :: equal_rank3
    real(dp) :: a(:,:,:), b(:,:,:), rtolerance
    real(dp) :: atolerance
    real(dp), OPTIONAL :: atolerance_
    if(present(atolerance_)) then; atolerance = atolerance_; else; atolerance = 5E-4_dp; endif

    equal_rank3 = .false.
    if(all(abs(a-b) == 0.0)) then
       equal_rank3 = .true. !This line was added so that if a user did
    !request a comparison with a tolerance of zero it would return the
    !correct result, or if the values are actually zero. We added this
    !line instead of making the following one <= so that the codes
    !original functionallity would be unaltered.
    else if(all(abs(a - b) < atolerance + rtolerance * max(maxval(abs(a)),maxval(abs(b))))) then
       equal_rank3 = .true.
    end if
  end function equal_rank3

  !!<summary>This function takes two real entities and compares them
  !! to see if they are equal within some tolerance. This prevents
  !! failed comparisons due to numbers that are "equal" but differ due
  !! to small differences arising from finite precision.</summary>
  !!<parameter name="a" regular="true">The first real scalar to be
  !!compared.</parameter>
  !!<parameter name="b" regular="true">The second real scalar to be
  !!compared.</parameter>
  !!<parameter name="rtolerance" regular="true">The relative tolerance for their comparison
  !! which is multiplied to the larger of a and b.</parameter>
  !!<parameter name="atolerance_" regular="true">The optional absolute
  !!tolerance for their comparison. Is added to the relative tolerance.
  !!Default value is 5E-4</parameter>
  function equal_scalar(a, b, rtolerance, atolerance_)
    logical :: equal_scalar
    real(dp) :: a, b, rtolerance
    real(dp) :: atolerance
    real(dp), OPTIONAL :: atolerance_
    if(present(atolerance_)) then; atolerance = atolerance_; else; atolerance = 5E-4_dp; endif

    equal_scalar = .false.
    if(abs(a-b) == 0.0) then
       equal_scalar = .true. !This line was added so that if a user did
    !request a comparison with a tolerance of zero it would return the
    !correct result, or if the values are actually zero. We added this
    !line instead of making the following one <= so that the codes
    !original functionallity would be unaltered.
    else if(abs(a - b) < atolerance + rtolerance * max(abs(a),abs(b))) then
       equal_scalar = .true.
    end if
  end function equal_scalar

  !!<summary>This function takes two real entities and compares them
  !! to see if they are equal within some tolerance. This prevents
  !! failed comparisons due to numbers that are "equal" but differ due
  !! to small differences arising from finite precision.</summary>
  !!<parameter name="a" regular="true">The first integer to be
  !!compared.</parameter>
  !!<parameter name="b" regular="true">The second real to be
  !!compared.</parameter>
  !!<parameter name="rtolerance" regular="true">The relative tolerance for their comparison
  !! which is multiplied to the larger of a and b.</parameter>
  !!<parameter name="atolerance_" regular="true">The optional absolute
  !!tolerance for their comparison. Is added to the relative tolerance.
  !!Default value is 5E-4</parameter>
  function equal_scalar_real_int(a, b, rtolerance, atolerance_)
    logical :: equal_scalar_real_int
    integer :: b
    real(dp) :: a, rtolerance
    real(dp) :: atolerance
    real(dp), OPTIONAL :: atolerance_
    if(present(atolerance_)) then; atolerance = atolerance_; else; atolerance = 5E-4_dp; endif

    equal_scalar_real_int = .false.
    if(abs(a-b) == 0.0) then
       equal_scalar_real_int = .true. !This line was added so that if a user did
    !request a comparison with a tolerance of zero it would return the
    !correct result, or if the values are actually zero. We added this
    !line instead of making the following one <= so that the codes
    !original functionallity would be unaltered.
    else if(abs(a - b) < atolerance + rtolerance * max(abs(a),abs(real(b,dp)))) then
       equal_scalar_real_int = .true.
    end if
  end function equal_scalar_real_int

  !!<summary>This function takes two real entities and compares them
  !! to see if they are equal within some tolerance. This prevents
  !! failed comparisons due to numbers that are "equal" but differ due
  !! to small differences arising from finite precision.</summary>
  !!<parameter name="a" regular="true">The first integer to be
  !!compared.</parameter>
  !!<parameter name="b" regular="true">The second integer to be
  !!compared.</parameter>
  !!<parameter name="rtolerance" regular="true">The relative tolerance for their comparison
  !! which is multiplied to the larger of a and b.</parameter>
  !!<parameter name="atolerance_" regular="true">The optional absolute
  !!tolerance for their comparison. Is added to the relative tolerance.
  !!Default value is 5E-4</parameter>
  function equal_scalar_int_int(a, b, rtolerance, atolerance_)
    logical :: equal_scalar_int_int
    real(dp) ::  rtolerance, atolerance
    real(dp), OPTIONAL :: atolerance_
    integer :: a, b
    if(present(atolerance_)) then; atolerance = atolerance_; else; atolerance = 5E-4_dp; endif

    equal_scalar_int_int = .false.
    if(abs(a-b) == 0) then
       equal_scalar_int_int = .true. !This line was added so that if a user did
    !request a comparison with a tolerance of zero it would return the
    !correct result, or if the values are actually zero. We added this
    !line instead of making the following one <= so that the codes
    !original functionallity would be unaltered.
    else if(abs(a - b) < atolerance + rtolerance * max(abs(real(a,dp)),abs(real(b,dp)))) then
       equal_scalar_int_int = .true.
    end if
  end function equal_scalar_int_int

  !!<summary>This function takes two real entities and compares them
  !! to see if they are equal within some tolerance. This prevents
  !! failed comparisons due to numbers that are "equal" but differ due
  !! to small differences arising from finite precision.</summary>
  !!<parameter name="a" regular="true">The first 1D array to be
  !!compared.</parameter>
  !!<parameter name="b" regular="true">The second real scalar to be
  !!compared.</parameter>
  !!<parameter name="rtolerance" regular="true">The relative tolerance for their comparison
  !! which is multiplied to the larger of a and b.</parameter>
  !!<parameter name="atolerance_" regular="true">The optional absolute
  !!tolerance for their comparison. Is added to the relative tolerance.
  !!Default value is 5E-4</parameter>
  function equal_rank1_rank0(a, b, rtolerance, atolerance_)
    logical :: equal_rank1_rank0
    real(dp) :: a(:), b, rtolerance, atolerance
    real(dp), OPTIONAL :: atolerance_
    if(present(atolerance_)) then; atolerance = atolerance_; else; atolerance = 5E-4_dp; endif

    equal_rank1_rank0 = .false.
    if(all(abs(a-b) == 0.0)) then
       equal_rank1_rank0 = .true. !This line was added so that if a user did
    !request a comparison with a tolerance of zero it would return the
    !correct result, or if the values are actually zero. We added this
    !line instead of making the following one <= so that the codes
    !original functionallity would be unaltered.
    else if(all(abs(a - b) < atolerance + rtolerance * max(maxval(abs(a)),abs(b)))) then
       equal_rank1_rank0 = .true.
    end if
  end function equal_rank1_rank0

  !!<summary>This function takes two real entities and compares them
  !! to see if they are equal within some tolerance. This prevents
  !! failed comparisons due to numbers that are "equal" but differ due
  !! to small differences arising from finite precision.</summary>
  !!<parameter name="a" regular="true">The first 2D array to be
  !!compared.</parameter>
  !!<parameter name="b" regular="true">The second real scalar to be
  !!compared.</parameter>
  !!<parameter name="rtolerance" regular="true">The relative tolerance for their comparison
  !! which is multiplied to the larger of a and b.</parameter>
  !!<parameter name="atolerance_" regular="true">The optional absolute
  !!tolerance for their comparison. Is added to the relative tolerance.
  !!Default value is 5E-4</parameter>
  function equal_rank2_rank0(a, b, rtolerance, atolerance_)
    logical :: equal_rank2_rank0
    real(dp) :: a(:,:), b, rtolerance, atolerance
    real(dp), OPTIONAL :: atolerance_
    if(present(atolerance_)) then; atolerance = atolerance_; else; atolerance = 5E-4_dp; endif

    equal_rank2_rank0 = .false.
    if(all(abs(a-b) == 0.0)) then
       equal_rank2_rank0 = .true. !This line was added so that if a user did
    !request a comparison with a tolerance of zero it would return the
    !correct result, or if the values are actually zero. We added this
    !line instead of making the following one <= so that the codes
    !original functionallity would be unaltered.
    else if(all(abs(a - b) < atolerance + rtolerance * max(maxval(abs(a)),abs(b)))) then
       equal_rank2_rank0 = .true.
    end if
  end function equal_rank2_rank0

  !!<summary>This function takes two real entities and compares them
  !! to see if they are equal within some tolerance. This prevents
  !! failed comparisons due to numbers that are "equal" but differ due
  !! to small differences arising from finite precision.</summary>
  !!<parameter name="a" regular="true">The first real 2D array to be
  !!compared.</parameter>
  !!<parameter name="b" regular="true">The second integer 2D array to be
  !!compared.</parameter>
  !!<parameter name="rtolerance" regular="true">The relative tolerance for their comparison
  !! which is multiplied to the larger of a and b.</parameter>
  !!<parameter name="atolerance_" regular="true">The optional absolute
  !!tolerance for their comparison. Is added to the relative tolerance.
  !!Default value is 5E-4</parameter>
  function equal_rank2_real_int(a, b, rtolerance, atolerance_)
    logical :: equal_rank2_real_int
    real(dp) :: a(:,:), rtolerance, atolerance
    real(dp), OPTIONAL :: atolerance_
    integer :: b(:,:)
    if(present(atolerance_)) then; atolerance = atolerance_; else; atolerance = 5E-4_dp; endif


    equal_rank2_real_int = .false.
    if(all(abs(a-b) == 0.0)) then
       equal_rank2_real_int = .true. !This line was added so that if a user did
    !request a comparison with a tolerance of zero it would return the
    !correct result, or if the values are actually zero. We added this
    !line instead of making the following one <= so that the codes
    !original functionallity would be unaltered.
    else if(all(abs(a - b) < atolerance + rtolerance * max(maxval(abs(a)),maxval(abs(real(b,dp)))))) then
       equal_rank2_real_int = .true.
    end if
  end function equal_rank2_real_int

  !!<summary>This function takes two real entities and compares them
  !! to see if they are equal within some tolerance. This prevents
  !! failed comparisons due to numbers that are "equal" but differ due
  !! to small differences arising from finite precision.</summary>
  !!<parameter name="a" regular="true">The first 1D real array to be
  !!compared.</parameter>
  !!<parameter name="b" regular="true">The second 1D integer array to be
  !!compared.</parameter>
  !!<parameter name="rtolerance" regular="true">The relative tolerance for their comparison
  !! which is multiplied to the larger of a and b.</parameter>
  !!<parameter name="atolerance_" regular="true">The optional absolute
  !!tolerance for their comparison. Is added to the relative tolerance.
  !!Default value is 5E-4</parameter>
  function equal_rank1_real_int(a, b, rtolerance, atolerance_)
    logical :: equal_rank1_real_int
    real(dp) :: a(:), rtolerance, atolerance
    real(dp), OPTIONAL :: atolerance_
    integer :: b(:)
    if(present(atolerance_)) then; atolerance = atolerance_; else; atolerance = 5E-4_dp; endif

    equal_rank1_real_int = .false.
    if(all(abs(a-b) == 0.0)) then
       equal_rank1_real_int = .true. !This line was added so that if a user did
    !request a comparison with a tolerance of zero it would return the
    !correct result, or if the values are actually zero. We added this
    !line instead of making the following one <= so that the codes
    !original functionallity would be unaltered.
    else if(all(abs(a - b) < atolerance + rtolerance * max(maxval(abs(a)),maxval(abs(real(b,dp)))))) then
       equal_rank1_real_int = .true.
    end if
  end function equal_rank1_real_int


END MODULE numerical_utilities
