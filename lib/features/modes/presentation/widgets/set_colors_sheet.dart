import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/custom_button.dart';
import 'package:nextgen_reeftech/features/global/utils/global_widgets/global_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../global/constants/heights_widths.dart';
import '../../../global/resources/resources.dart';
import '../../data/model/color_label_model.dart';
import '../provider/mode_vm.dart';

class SetColorsSheet extends StatefulWidget {
 final  int index;
 final  int selectedColorID;
  const SetColorsSheet({Key? key,required this.index,required this.selectedColorID}) : super(key: key);

  @override
  State<SetColorsSheet> createState() => _SetColorsSheetState();
}

class _SetColorsSheetState extends State<SetColorsSheet> {
  int selectedIndex = 0;

  @override
  void initState() {
    ModeVM vm=context.read<ModeVM>();
    selectedIndex=vm.colorOptions.indexWhere((e)=>e.id==widget.selectedColorID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModeVM>(
        builder: (context,vm,_) {
          return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlobalWidgets.bottomHorBar(),
              AppBar(
                centerTitle: true,
                backgroundColor: R.appColors.white,
                leading: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                    child: Icon(Icons.close,color: R.appColors.black,size: 24,)),
                title: Text("Select Color",style: R.textStyles.poppins().copyWith(
                  fontWeight: FontWeight.w600,fontSize: 16.px,color: R.appColors.appBarTitle
                ),),
              ),

              h3,
              GestureDetector(
                onPanUpdate: (details) {
                  final box = context.findRenderObject() as RenderBox?;
                  if (box != null) {
                    final localOffset = box.globalToLocal(details.globalPosition);
                    final rowHeight = 56.0;
                    int index = (localOffset.dy / rowHeight).floor();
                    if (index >= 0 && index < vm.colorOptions.length && selectedIndex != index) {
                      setState(() => selectedIndex = index);
                    }
                  }
                },
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vm.colorOptions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final option = vm.colorOptions[index];
                    final isSelected = selectedIndex == index;
                    return colorTile(index,isSelected,option);
                  },
                ),
              ),
              h7,
              CustomButton(onPressed: (){
                vm.channels[widget.index].color=vm.colorOptions[selectedIndex];
                vm.update();
                Get.back();

              }, title: "save")
            ],
          ),
        );
      }
    );
  }
  Widget colorTile(int index,bool isSelected,ColorOption option)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 2,
          child: isSelected
              ? Image.asset(
            R.appImages.indicator,
            width: 21,
            height: 21,
          )
              : Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: R.appColors.indicatorGrey,
              shape: BoxShape.circle,
            ),
          ),
        ),
        w2,
        Expanded(flex: 20,
          child: GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);

            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? option.color : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: option.color,
                  width: 0.7.px,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      option.label,
                      style: TextStyle(
                        fontSize: 15.px,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? (option.color == Colors.white ? Colors.black : Colors.white)
                            : R.appColors.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: option.color,
                      shape: BoxShape.circle,
                      boxShadow:isSelected?[]: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

