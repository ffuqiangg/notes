### 一些 Sublime Text 4 的默认设置修改方法  
选择菜单 `首选项` > `设置`，然后根据需要添加下面的代码

1. 在 manjaro gnome 中修复标题栏高度  
`"gtk_client_side_window_decorations": false,`  
2. 按下 tab 键缩进显示的宽度  
`"tab_size": 4,`  
3. 将 tab 缩进转为空格缩进  
`"translate_tabs_to_spaces": true,`  
4. 保存时转换 tab  
`"expand_tabs_on_save": true,`  
5. 保存时自动删除行尾空格  
`"trim_trailing_white_space_on_save": true,`  
6. 设置字符大小  
`"font_size": 11,`  
7. 设置字体  
`"font_face": "Fira Code",`  
8. 自动换行，如果取值 auto 需要加双引号  
`"word_wrap": true,`  
9. 调整行高，上下行距单位像素  
`"line_padding_top": 4,`  
`"line_padding_bottom": 4,`  
10. 修改默认换行符，默认为操作系统风格。windows 平台要使用 unix 换行符或相反就需要设置  
`"default_line_ending": "unix",`
