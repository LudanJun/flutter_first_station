import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../models/audio_option.dart';

class AudioOptionPanel extends StatelessWidget {
  final List<AudioOption> audioOptions;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  const AudioOptionPanel({
    super.key,
    required this.audioOptions,
    required this.activeIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Material(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
                height: 46,
                alignment: Alignment.center,
                child: const Text(
                  "选择音效",
                  style: labelStyle,
                )),
            ...List.generate(audioOptions.length, _buildByIndex)
          ],
        ),
      ),
    );
  }

//  根据索引构建Widget
  Widget _buildByIndex(int index) {
    bool active = index == activeIndex; //  判断当前索引是否为活动索引
    return ListTile(
      selected: active, //  设置选中状态
      onTap: () => onSelect(index), //  点击事件
      title: Text(audioOptions[index].name), //  设置标题
      trailing: IconButton(
        //  设置尾部按钮
        splashRadius: 20, //  设置水波纹半径
        onPressed: () => _tempPlay(audioOptions[index].src), //  点击事件
        icon: const Icon(
          //  设置图标
          Icons.record_voice_over_rounded,
          color: Colors.blue,
        ),
      ),
    );
  }

  //  播放音频
  void _tempPlay(String src) async {
    //  创建音频池
    AudioPool pool = await FlameAudio.createPool(src, maxPlayers: 1);
    pool.start(); //  播放音频
  }
}
