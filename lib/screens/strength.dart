import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_slide_rule/commons/widgets/drawer.dart';
import 'package:smart_slide_rule/models/strength.dart';

class Strength extends StatelessWidget {
  const Strength({super.key});

  @override
  Widget build(BuildContext context) {
    var _StrengthModel = Provider.of<StrengthModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('強度計算', style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ListView(
          children: [
            Text(
              'たわみ計算',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            Container(
              alignment: Alignment.center,
              child: DropdownButton<String>(
                value: _StrengthModel.calcModel,
                style: Theme.of(context).textTheme.headline6,
                onChanged: (String? newText) {
                  _StrengthModel.setCalcModel(newText!);
                },
                items: _StrengthModel.itemsOfCalcModel
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Text(
              '基準板厚(mm): ' + _StrengthModel.refThick.round().toString(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            // reference thickness
            Slider(
              value: _StrengthModel.refThick,
              min: 3,
              max: 20,
              label: _StrengthModel.refThick.round().toString(),
              onChanged: (double value) {
                _StrengthModel.setRefThick(value);
                _StrengthModel.calcBendingDeflection();
              }
            ),
            Text(
              '部材の長さ(m): ' + _StrengthModel.beamLength.round().toString(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            // beam length
            Slider(
              value: _StrengthModel.beamLength,
              min: 0,
              max: 10,
              label: _StrengthModel.beamLength.round().toString(),
              onChanged: (double value) {
                _StrengthModel.setBeamLength(value);
                _StrengthModel.calcBendingDeflection();
              },
              activeColor: Colors.red,
            ),
            Text(
              '部材のヤング率(GPa):' + _StrengthModel.modulusYoung.round().toString(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            // modulus Young
            Slider(
              value: _StrengthModel.modulusYoung,
              min: 20,
              max: 210,
              label: _StrengthModel.modulusYoung.round().toString(),
              onChanged: (double value) {
                _StrengthModel.setModulusYoung(value);
                _StrengthModel.calcBendingDeflection();
              }
            ),
            // moment of inertia of area m4
            Text(
              '断面２次モーメント(m4): ' + pow(10, _StrengthModel.inertiaOfArea).round().toString(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Slider(
              value: _StrengthModel.inertiaOfArea,
              min: 1,
              max: 6,
              label: _StrengthModel.inertiaOfArea.round().toString(),
              onChanged: (double value) {
                _StrengthModel.setInertiaOfArea(value);
                _StrengthModel.calcBendingDeflection();
              }
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.grey,
                    width: 80,
                    height: 80,
                  )
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Ymax: ' + _StrengthModel.yMax.toString(),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          'Imax: ' + _StrengthModel.iMax.toString(),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ]
                    ),
                  ),
                ),

              ]
            ),
            Text(
              '[参考部材]',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              'SS400 L 60x60x5, AL5052 L 60x60x10, SS400 C 100x50x4, ...',
              style: Theme.of(context).textTheme.headline6,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('部材をカタログに追加'),
            )
          ],
        ),
    );
  }
}
