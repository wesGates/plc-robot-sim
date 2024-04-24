MODULE Module1
    CONST robtarget pPick:=[[300.023,150,209.481],[0,-0.707106781,0.707106781,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    !***********************************************************
    !
    ! Module:  Module1
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: ander
    !
    ! Version: 1.0
    !
    !***********************************************************


    !***********************************************************
    !
    ! Procedure main
    !
    !   Smart Component example, Pick and Place application.
    
    !
    !***********************************************************
    PROC main()
        WHILE TRUE DO
            PickPart;
        ENDWHILE
    ENDPROC

    PROC PickPart()
        !** The robot moves to a wait position 200 mm above the pick position. **
        MoveJ Offs(pPick,0,0,200),v500,z1,tVacuum\WObj:=wobjInFeeder;
        !** The robot waits for a box to pick at the infeeder stop. **
        WaitDI diBoxInPos,1;
        !** The robot goes to the pick position. **
        MoveL pPick,v100,fine,tVacuum\WObj:=wobjInFeeder;
        !** To attach the box, the robot turns on the digital output signal "doVacuum" which is connected to the Smart Component "SC_VacuumTool". **
        SetDO doVacuum,1;
        !** The robot waits for the digital input signal "diVacuum" to goes high, which comes from "SC_VacuumTool" and indicates that the box is attached. **
        WaitDI diVacuum,1;
        !** The robot moves up from the infeeder. **
        MoveL Offs(pPick,0,0,200),v500,z1,tVacuum\WObj:=wobjInFeeder;
        !** The robot moves to the drop position above the pallet. **
        MoveL Offs(pPick,0,-800,200),v500,fine,tVacuum\WObj:=wobjInFeeder;
        !** To detach the box, the robot turns off the digital output signal "doVacuum" which is connected to the Smart Component "SC_VacuumTool". **
        SetDO doVacuum,0;
        !** The robot waits for the digital input signal "diVacuum" to goes low, which comes from "SC_VacuumTool" and indicates that the box is detached. **
        WaitDI diVacuum,0;
        !** The wait time simulates the time it takes for a real vacuum gripper to loose the vacuum. **
        WaitTime 0.5;
    ENDPROC
ENDMODULE