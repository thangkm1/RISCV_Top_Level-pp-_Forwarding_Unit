# RISCV_Top_Level-pp-_Forwarding_Unit
[forwarding_unit.drawio](https://github.com/user-attachments/files/26835124/forwarding_unit.drawio)
<img width="787" height="406" alt="top_lv(pp) drawio" src="https://github.com/user-attachments/assets/1c56e424-41b3-4279-99a4-928ce8e5f3fc" />
<mxfile host="app.diagrams.net">
  <diagram name="top_level_pp" id="RozpIHUSLB00ANIpORL5">
    <mxGraphModel dx="1245" dy="750" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="827" pageHeight="1169" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-16" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;fontSize=20;fontStyle=1;" value="forwarding_unit SPEC (2-stage pipeline)" vertex="1">
          <mxGeometry height="40" width="680" x="460" y="30" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-17" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f8cecc;strokeColor=#b85450;fontStyle=1;fontSize=16;" value="forwarding_unit" vertex="1">
          <mxGeometry height="300" width="300" x="650" y="135" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-18" parent="1" style="shape=parallelogram;perimeter=parallelogramPerimeter;whiteSpace=wrap;html=1;fillColor=#fff2cc;strokeColor=#d6b656;" value="rs1[4:0]" vertex="1">
          <mxGeometry height="50" width="170" x="414" y="182.5" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-19" parent="1" style="shape=parallelogram;perimeter=parallelogramPerimeter;whiteSpace=wrap;html=1;fillColor=#fff2cc;strokeColor=#d6b656;" value="rs2[4:0]" vertex="1">
          <mxGeometry height="50" width="170" x="414" y="235" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-20" parent="1" style="shape=parallelogram;perimeter=parallelogramPerimeter;whiteSpace=wrap;html=1;fillColor=#fff2cc;strokeColor=#d6b656;" value="rd_E[4:0]" vertex="1">
          <mxGeometry height="50" width="170" x="414" y="285" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-21" parent="1" style="shape=parallelogram;perimeter=parallelogramPerimeter;whiteSpace=wrap;html=1;fillColor=#fff2cc;strokeColor=#d6b656;" value="regwrite_E" vertex="1">
          <mxGeometry height="50" width="170" x="414" y="335" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-22" parent="1" style="shape=parallelogram;perimeter=parallelogramPerimeter;whiteSpace=wrap;html=1;fillColor=#d5e8d4;strokeColor=#82b366;" value="forwardA[1:0]" vertex="1">
          <mxGeometry height="55" width="190" x="1010" y="230" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-23" parent="1" style="shape=parallelogram;perimeter=parallelogramPerimeter;whiteSpace=wrap;html=1;fillColor=#d5e8d4;strokeColor=#82b366;" value="forwardB[1:0]" vertex="1">
          <mxGeometry height="55" width="190" x="1010" y="285" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-24" edge="1" parent="1" source="AX0cB228Y0cx9Q8KDM_u-18" style="endArrow=classic;html=1;rounded=0;strokeWidth=2;entryX=0;entryY=0.25;entryDx=0;entryDy=0;" target="AX0cB228Y0cx9Q8KDM_u-17" value="">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-25" edge="1" parent="1" source="AX0cB228Y0cx9Q8KDM_u-19" style="endArrow=classic;html=1;rounded=0;strokeWidth=2;" value="">
          <mxGeometry relative="1" as="geometry">
            <mxPoint x="648" y="258" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-26" edge="1" parent="1" source="AX0cB228Y0cx9Q8KDM_u-20" style="endArrow=classic;html=1;rounded=0;strokeWidth=2;entryX=-0.001;entryY=0.573;entryDx=0;entryDy=0;entryPerimeter=0;" target="AX0cB228Y0cx9Q8KDM_u-17" value="">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-27" edge="1" parent="1" source="AX0cB228Y0cx9Q8KDM_u-21" style="endArrow=classic;html=1;rounded=0;strokeWidth=2;entryX=0;entryY=0.75;entryDx=0;entryDy=0;" target="AX0cB228Y0cx9Q8KDM_u-17" value="">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-28" edge="1" parent="1" source="AX0cB228Y0cx9Q8KDM_u-17" style="endArrow=classic;html=1;rounded=0;strokeWidth=2;strokeColor=#82b366;exitX=1.002;exitY=0.403;exitDx=0;exitDy=0;exitPerimeter=0;" target="AX0cB228Y0cx9Q8KDM_u-22" value="">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="AX0cB228Y0cx9Q8KDM_u-29" edge="1" parent="1" source="AX0cB228Y0cx9Q8KDM_u-17" style="endArrow=classic;html=1;rounded=0;strokeWidth=2;strokeColor=#82b366;exitX=0.999;exitY=0.595;exitDx=0;exitDy=0;exitPerimeter=0;" target="AX0cB228Y0cx9Q8KDM_u-23" value="">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
