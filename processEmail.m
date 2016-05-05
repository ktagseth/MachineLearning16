function word_indices = processEmail(email_contents)%,word_indices)
%PROCESSEMAIL preprocesses a the body of an email and
%returns a list of word_indices 
%   word_indices = PROCESSEMAIL(email_contents) preprocesses 
%   the body of an email and returns a list of indices of the 
%   words contained in the email. 
%

% Load Vocabulary
vocabList = getVocabList();

% Init return value
word_indices = [];

% ========================== Preprocess Email ===========================

% Find the Headers ( \n\n and remove )
% Uncomment the following lines if you are working with raw emails with the
% full headers

% hdrstart = strfind(email_contents, ([char(10) char(10)]));
% email_contents = email_contents(hdrstart(1):end);

% Lower case
email_contents = lower(email_contents);

% Strip all HTML
% Looks for any expression that starts with < and ends with > and replace
% and does not have any < or > in the tag it with a space
email_contents = regexprep(email_contents, '<[^<>]+>', ' ');

% Handle Numbers
% Look for one or more characters between 0-9
email_contents = regexprep(email_contents, '[0-9]+', 'number');

%used for emojis,
%probably not necessary but is useful in overal sentiment analysis
email_contents = regexprep(email_contents, '[: )]+', 'good');
email_contents = regexprep(email_contents, '[:)]+', 'good');
email_contents = regexprep(email_contents, '[:D]+', 'good');
email_contents = regexprep(email_contents, '[:o)]+', 'good');
email_contents = regexprep(email_contents, '[:]]+', 'good');
email_contents = regexprep(email_contents, '[:3]+', 'good');
email_contents = regexprep(email_contents, '[:c)]+', 'good');
email_contents = regexprep(email_contents, '[:>]+', 'good');
email_contents = regexprep(email_contents, '[=]]+', 'good');
email_contents = regexprep(email_contents, '[8)]+', 'good');
email_contents = regexprep(email_contents, '[=)]+', 'good');
email_contents = regexprep(email_contents, '[:} ]+', 'good');
email_contents = regexprep(email_contents, '[:^)]+', 'good');
email_contents = regexprep(email_contents, '[:っ)]+', 'good');
email_contents = regexprep(email_contents, '[: D]+', 'good');
email_contents = regexprep(email_contents, '[8 D]+', 'good');
email_contents = regexprep(email_contents, '[8D]+', 'good');
email_contents = regexprep(email_contents, '[x D ]+', 'good');
email_contents = regexprep(email_contents, '[xD]+', 'good');
email_contents = regexprep(email_contents, '[X D]+', 'good');
email_contents = regexprep(email_contents, '[XD]+', 'good');
email_contents = regexprep(email_contents, '[= D ]+', 'good');
email_contents = regexprep(email_contents, '[=D]+', 'good');
email_contents = regexprep(email_contents, '[= 3]+', 'good');
email_contents = regexprep(email_contents, '[=3]+', 'good');
email_contents = regexprep(email_contents, '[B^D]+', 'good');
email_contents = regexprep(email_contents, '[:-))]+', 'good');
email_contents = regexprep(email_contents, '[>:[]+', 'bad');
email_contents = regexprep(email_contents, '[: (]+', 'bad');
email_contents = regexprep(email_contents, '[:(]+', 'bad');
email_contents = regexprep(email_contents, '[: c]+', 'bad');
email_contents = regexprep(email_contents, '[:c]+', 'bad');
email_contents = regexprep(email_contents, '[: <]+', 'bad');
email_contents = regexprep(email_contents, '[:っC]+', 'bad');
email_contents = regexprep(email_contents, '[:<]+', 'bad');
email_contents = regexprep(email_contents, '[: []+', 'bad');
email_contents = regexprep(email_contents, '[:[]+', 'bad');
email_contents = regexprep(email_contents, '[:{]+', 'bad');
email_contents = regexprep(email_contents, '[;(]+', 'bad');
email_contents = regexprep(email_contents, '[:-||]+', 'bad');
email_contents = regexprep(email_contents, '[:@]+', 'bad');
email_contents = regexprep(email_contents, '[>:(]+', 'bad');
email_contents = regexprep(email_contents, '[:' (]+', 'bad');
email_contents = regexprep(email_contents, '[:'(]+', 'bad');
email_contents = regexprep(email_contents, '[:' )]+', 'good');
email_contents = regexprep(email_contents, '[:')]+', 'good');
email_contents = regexprep(email_contents, '[D:<]+', 'bad');
email_contents = regexprep(email_contents, '[D:]+', 'bad');
email_contents = regexprep(email_contents, '[D8]+', 'bad');
email_contents = regexprep(email_contents, '[D;]+', 'bad');
email_contents = regexprep(email_contents, '[D= ]+', 'bad');
email_contents = regexprep(email_contents, '[DX]+', 'bad');
email_contents = regexprep(email_contents, '[v.v]+', 'bad');
email_contents = regexprep(email_contents, '[D ':]+', 'bad');
email_contents = regexprep(email_contents, '[>:O]+', 'bad');
email_contents = regexprep(email_contents, '[: O]+', 'bad');
email_contents = regexprep(email_contents, '[:O]+', 'bad');
email_contents = regexprep(email_contents, '[: o]+', 'bad');
email_contents = regexprep(email_contents, '[:o]+', 'bad');
email_contents = regexprep(email_contents, '[8 0]+', 'bad');
email_contents = regexprep(email_contents, '[O_O]+', 'bad');
email_contents = regexprep(email_contents, '[o o ]+', 'bad');
email_contents = regexprep(email_contents, '[O_o]+', 'bad');
email_contents = regexprep(email_contents, '[o_O]+', 'bad');
email_contents = regexprep(email_contents, '[o_o ]+', 'bad');
email_contents = regexprep(email_contents, '[O-O]+', 'bad');
email_contents = regexprep(email_contents, '[:*]+', 'good');
email_contents = regexprep(email_contents, '[:-*]+', 'good');
email_contents = regexprep(email_contents, '[^*]+', 'good');
email_contents = regexprep(email_contents, '[( ‘}{‘ )]+', 'good');
email_contents = regexprep(email_contents, '[; )]+', 'good');
email_contents = regexprep(email_contents, '[;)]+', 'good');
email_contents = regexprep(email_contents, '[*-)]+', 'good');
email_contents = regexprep(email_contents, '[*)]+', 'good');
email_contents = regexprep(email_contents, '[; ]]+', 'good');
email_contents = regexprep(email_contents, '[;]]+', 'good');
email_contents = regexprep(email_contents, '[;D]+', 'good');
email_contents = regexprep(email_contents, '[;^)]+', 'good');
email_contents = regexprep(email_contents, '[: ,]+', 'good');
email_contents = regexprep(email_contents, '[>:P]+', 'good');
email_contents = regexprep(email_contents, '[: P]+', 'good');
email_contents = regexprep(email_contents, '[:P]+', 'good');
email_contents = regexprep(email_contents, '[X P ]+', 'good');
email_contents = regexprep(email_contents, '[x p]+', 'good');
email_contents = regexprep(email_contents, '[xp]+', 'good');
email_contents = regexprep(email_contents, '[XP]+', 'good');
email_contents = regexprep(email_contents, '[: p]+', 'good');
email_contents = regexprep(email_contents, '[:p]+', 'good');
email_contents = regexprep(email_contents, '[=p]+', 'good');
email_contents = regexprep(email_contents, '[: Þ]+', 'good');
email_contents = regexprep(email_contents, '[:Þ]+', 'good');
email_contents = regexprep(email_contents, '[:þ]+', 'good');
email_contents = regexprep(email_contents, '[: þ ]+', 'good');
email_contents = regexprep(email_contents, '[: b]+', 'good');
email_contents = regexprep(email_contents, '[:b]+', 'good');
email_contents = regexprep(email_contents, '[d:]+', 'good');
email_contents = regexprep(email_contents, '[>:\]+', 'bad');
email_contents = regexprep(email_contents, '[>:/]+', 'bad');
email_contents = regexprep(email_contents, '[: /]+', 'bad');
email_contents = regexprep(email_contents, '[: .]+', 'bad');
email_contents = regexprep(email_contents, '[:/]+', 'bad');
email_contents = regexprep(email_contents, '[:\ ]+', 'bad');
email_contents = regexprep(email_contents, '[=/]+', 'bad');
email_contents = regexprep(email_contents, '[=\]+', 'bad');
email_contents = regexprep(email_contents, '[:L]+', 'bad');
email_contents = regexprep(email_contents, '[=L]+', 'bad');
email_contents = regexprep(email_contents, '[:S]+', 'bad');
email_contents = regexprep(email_contents, '[>.<]+', 'bad');
email_contents = regexprep(email_contents, '[:|]+', 'bad');
email_contents = regexprep(email_contents, '[: |]+', 'bad');
email_contents = regexprep(email_contents, '[:$]+', 'bad');
email_contents = regexprep(email_contents, '[: X]+', 'bad');
email_contents = regexprep(email_contents, '[:X]+', 'bad');
email_contents = regexprep(email_contents, '[: #]+', 'bad');
email_contents = regexprep(email_contents, '[:#]+', 'bad');
email_contents = regexprep(email_contents, '[>:)]+', 'bad');
email_contents = regexprep(email_contents, '[>;)]+', 'bad');
email_contents = regexprep(email_contents, '[>: )]+', 'bad');
email_contents = regexprep(email_contents, '[}: )]+', 'bad');
email_contents = regexprep(email_contents, '[}:)]+', 'bad');
email_contents = regexprep(email_contents, '[3: )]+', 'bad');
email_contents = regexprep(email_contents, '[3:)]+', 'bad');
email_contents = regexprep(email_contents, '[O: )]+', 'good');
email_contents = regexprep(email_contents, '[0: 3]+', 'good');
email_contents = regexprep(email_contents, '[0:3]+', 'good');
email_contents = regexprep(email_contents, '[0: ) ]+', 'good');
email_contents = regexprep(email_contents, '[0:)]+', 'good');
email_contents = regexprep(email_contents, '[0;^)]+', 'good');
email_contents = regexprep(email_contents, '[o/\o]+', 'good');
email_contents = regexprep(email_contents, '[^5]+', 'good');
email_contents = regexprep(email_contents, '[>_>^ ]+', 'good');
email_contents = regexprep(email_contents, '[^<_<]+', 'good');
email_contents = regexprep(email_contents, '[: J]+', 'good');
email_contents = regexprep(email_contents, '[# )]+', 'good');
email_contents = regexprep(email_contents, '[|; )]+', 'bad');
email_contents = regexprep(email_contents, '[| O]+', 'bad');
email_contents = regexprep(email_contents, '[: &]+', 'bad');
email_contents = regexprep(email_contents, '[:&]+', 'bad');
email_contents = regexprep(email_contents, '[% )]+', 'bad');
email_contents = regexprep(email_contents, '[%)]+', 'bad');
email_contents = regexprep(email_contents, '[: ###..]+', 'bad');
email_contents = regexprep(email_contents, '[:###..]+', 'bad');
email_contents = regexprep(email_contents, '[<: |]+', 'bad');
email_contents = regexprep(email_contents, '[ಠ_ಠ]+', 'bad');
email_contents = regexprep(email_contents, '[( ͡° ͜ʖ ͡°)]+', 'bad');
email_contents = regexprep(email_contents, '[( ͡°͜ ͡°)]+', 'bad');
email_contents = regexprep(email_contents, '[<*))) {]+', 'bad');
email_contents = regexprep(email_contents, '[><(((*>]+', 'bad');
email_contents = regexprep(email_contents, '[><>]+', 'bad');
email_contents = regexprep(email_contents, '[\o/]+', 'good');
email_contents = regexprep(email_contents, '[*\0/*]+', 'good');
email_contents = regexprep(email_contents, '[@} ; '    ]+', 'good');
email_contents = regexprep(email_contents, '[@>  >  ]+', 'good');
email_contents = regexprep(email_contents, '[~(_8^(I)]+', 'good');
email_contents = regexprep(email_contents, '[5: ) ]+', 'good');
email_contents = regexprep(email_contents, '[~: \]+', 'good');
email_contents = regexprep(email_contents, '[//0 0\\]+', 'good');
email_contents = regexprep(email_contents, '[*<|: )]+', 'good');
email_contents = regexprep(email_contents, '[=:o]]+', 'good');
email_contents = regexprep(email_contents, '[,: )]+', 'good');
email_contents = regexprep(email_contents, '[7:^]]+', 'good');
email_contents = regexprep(email_contents, '[<3]+', 'bad');
email_contents = regexprep(email_contents, '[</3]+', 'bad');

email_contents = regexprep(email_contents, '[(>_<)]+', 'bad');
email_contents = regexprep(email_contents, '[(>_<)>]+', 'bad');
email_contents = regexprep(email_contents, '[(^^ゞ]+', 'bad');
email_contents = regexprep(email_contents, '[(^_^;)]+', 'bad');
email_contents = regexprep(email_contents, '[(-_-;)]+', 'bad');
email_contents = regexprep(email_contents, '[(~_~;)]+', 'bad');
email_contents = regexprep(email_contents, '[(・。・;)]+', 'bad');
email_contents = regexprep(email_contents, '[(・_・;)]+', 'bad');
email_contents = regexprep(email_contents, '[(・・;)]+', 'bad');
email_contents = regexprep(email_contents, '[^^;]+', 'bad');
email_contents = regexprep(email_contents, '[^_^;]+', 'bad');
email_contents = regexprep(email_contents, '[(#^.^#)]+', 'bad');
email_contents = regexprep(email_contents, '[(^ ^;)]+', 'bad');
email_contents = regexprep(email_contents, '[(^。^)y-.。]+', 'bad');
email_contents = regexprep(email_contents, '[o○]+', 'bad');
email_contents = regexprep(email_contents, '[(-。-)y-゜゜゜]+', 'bad');
email_contents = regexprep(email_contents, '[(';')]+', 'good');
email_contents = regexprep(email_contents, '[.。]+', 'good');
email_contents = regexprep(email_contents, '[o○]+', 'good');
email_contents = regexprep(email_contents, '[○o。.]+', 'good');
email_contents = regexprep(email_contents, '[(-_-)zzz]+', 'good');
email_contents = regexprep(email_contents, '[(^_-)]+', 'good');
email_contents = regexprep(email_contents, '[(^_-)-☆]+', 'good');
email_contents = regexprep(email_contents, '[<コ:彡]+', 'good');
email_contents = regexprep(email_contents, '[((+_+))]+', 'bad');
email_contents = regexprep(email_contents, '[(+o+)]+', 'bad');
email_contents = regexprep(email_contents, '[(゜゜)]+', 'bad');
email_contents = regexprep(email_contents, '[(゜-゜)]+', 'bad');
email_contents = regexprep(email_contents, '[(゜.゜) ]+', 'bad');
email_contents = regexprep(email_contents, '[(゜_゜)]+', 'bad');
email_contents = regexprep(email_contents, '[(゜_゜>)]+', 'bad');
email_contents = regexprep(email_contents, '[(゜レ゜)]+', 'bad');
email_contents = regexprep(email_contents, '[(o|o)]+', 'good');
email_contents = regexprep(email_contents, '[^_^]+', 'good');
email_contents = regexprep(email_contents, '[(゜o゜)]+', 'good');
email_contents = regexprep(email_contents, '[(^_^)/]+', 'good');
email_contents = regexprep(email_contents, '[(^O^)／]+', 'good');
email_contents = regexprep(email_contents, '[(^o^)／]+', 'good');
email_contents = regexprep(email_contents, '[(^^)/]+', 'good');
email_contents = regexprep(email_contents, '[(≧∇≦)/]+', 'good');
email_contents = regexprep(email_contents, '[(/◕ヮ◕)/]+', 'good');
email_contents = regexprep(email_contents, '[(^o^)丿 ]+', 'good');
email_contents = regexprep(email_contents, '[∩(・ω・)∩]+', 'good');
email_contents = regexprep(email_contents, '[(・ω・) ^ω^]+', 'good');
email_contents = regexprep(email_contents, '[(__)]+', 'good');
email_contents = regexprep(email_contents, '[_(._.)_]+', 'good');
email_contents = regexprep(email_contents, '[_(_^_)_]+', 'good');
email_contents = regexprep(email_contents, '[<(_ _)>]+', 'good');
email_contents = regexprep(email_contents, '[<m(__)m>]+', 'good');
email_contents = regexprep(email_contents, '[m(__)m]+', 'good');
email_contents = regexprep(email_contents, '[m(_ _)m]+', 'good');
email_contents = regexprep(email_contents, '[(゜゜)～]+', 'good');
email_contents = regexprep(email_contents, '[( ^^) _U~~]+', 'good');
email_contents = regexprep(email_contents, '[( ^^) _旦~~]+', 'good');
email_contents = regexprep(email_contents, '[☆彡]+', 'good');
email_contents = regexprep(email_contents, '[☆ミ]+', 'good');
email_contents = regexprep(email_contents, '[>゜)))彡]+', 'good');
email_contents = regexprep(email_contents, '[(Q ))]+', 'good');
email_contents = regexprep(email_contents, '[><ヨヨ]+', 'good');
email_contents = regexprep(email_contents, '[(゜))<<]+', 'good');
email_contents = regexprep(email_contents, '[>゜))))彡]+', 'good');
email_contents = regexprep(email_contents, '[<゜)))彡]+', 'good');
email_contents = regexprep(email_contents, '[>゜))彡]+', 'good');
email_contents = regexprep(email_contents, '[<+ ))><<]+', 'good');
email_contents = regexprep(email_contents, '[<*)) >=<]+', 'good');
email_contents = regexprep(email_contents, '[Ｃ:。ミ]+', 'good');
email_contents = regexprep(email_contents, '[~>゜)～～～]+', 'good');
email_contents = regexprep(email_contents, '[＼(゜ロ＼)ココハドコ?]+', 'bad');
email_contents = regexprep(email_contents, '[(／ロ゜)／アタシハダアレ?]+', 'bad');
email_contents = regexprep(email_contents, '[('_')]+', 'bad');
email_contents = regexprep(email_contents, '[(/_;)]+', 'bad');
email_contents = regexprep(email_contents, '[(T_T)]+', 'bad');
email_contents = regexprep(email_contents, '[(;_;)]+', 'bad');
email_contents = regexprep(email_contents, '[(;_;]+', 'bad');
email_contents = regexprep(email_contents, '[(;_:) ]+', 'bad');
email_contents = regexprep(email_contents, '[(;O;)]+', 'bad');
email_contents = regexprep(email_contents, '[(:_;)]+', 'bad');
email_contents = regexprep(email_contents, '[(ToT)]+', 'bad');
email_contents = regexprep(email_contents, '[(Ｔ▽Ｔ)]+', 'bad');
email_contents = regexprep(email_contents, '[;_;]+', 'bad');
email_contents = regexprep(email_contents, '[;-;]+', 'bad');
email_contents = regexprep(email_contents, '[;n;]+', 'bad');
email_contents = regexprep(email_contents, '[;;]+', 'bad');
email_contents = regexprep(email_contents, '[Q.Q]+', 'bad');
email_contents = regexprep(email_contents, '[T.T]+', 'bad');
email_contents = regexprep(email_contents, '[QQ ]+', 'bad');
email_contents = regexprep(email_contents, '[Q_Q]+', 'bad');
email_contents = regexprep(email_contents, '[(ー_ー)!!]+', 'bad');
email_contents = regexprep(email_contents, '[(-.-)]+', 'bad');
email_contents = regexprep(email_contents, '[(-_-)]+', 'bad');
email_contents = regexprep(email_contents, '[( 一一)]+', 'bad');
email_contents = regexprep(email_contents, '[(；一_一)]+', 'bad');
email_contents = regexprep(email_contents, '[(=_=)]+', 'bad');
email_contents = regexprep(email_contents, '[(・・?]+', 'bad');
email_contents = regexprep(email_contents, '[(?_?)]+', 'bad');
email_contents = regexprep(email_contents, '[●～*]+', 'bad');
email_contents = regexprep(email_contents, '[～゜・_・゜～]+', 'good');
email_contents = regexprep(email_contents, '[(=^・^=)]+', 'good');
email_contents = regexprep(email_contents, '[(..)]+', 'bad');
email_contents = regexprep(email_contents, '[(._.)]+', 'bad');
email_contents = regexprep(email_contents, '[(－‸ლ)]+', 'bad');
email_contents = regexprep(email_contents, '[>^_^<]+', 'good');
email_contents = regexprep(email_contents, '[<^!^>]+', 'good');
email_contents = regexprep(email_contents, '[^/^]+', 'good');
email_contents = regexprep(email_contents, '[（*^_^*）]+', 'good');
email_contents = regexprep(email_contents, '[§^。^§]+', 'good');
email_contents = regexprep(email_contents, '[(^<^)]+', 'good');
email_contents = regexprep(email_contents, '[(^.^)]+', 'good');
email_contents = regexprep(email_contents, '[(^ム^)]+', 'good');
email_contents = regexprep(email_contents, '[(^・^)]+', 'good');
email_contents = regexprep(email_contents, '[(^。^)]+', 'good');
email_contents = regexprep(email_contents, '[(^_^.)]+', 'good');
email_contents = regexprep(email_contents, '[(^_^)]+', 'good');
email_contents = regexprep(email_contents, '[(^^)]+', 'good');
email_contents = regexprep(email_contents, '[(^J^)]+', 'good');
email_contents = regexprep(email_contents, '[(*^。^*)]+', 'good');
email_contents = regexprep(email_contents, '[^_^]+', 'good');
email_contents = regexprep(email_contents, '[(#^.^#)]+', 'good');
email_contents = regexprep(email_contents, '[（＾－＾）]+', 'good');
email_contents = regexprep(email_contents, '[(^^)/~~~]+', 'good');
email_contents = regexprep(email_contents, '[(^_^)/~]+', 'good');
email_contents = regexprep(email_contents, '[(;_;)/~~~ ]+', 'good');
email_contents = regexprep(email_contents, '[(^.^)/~~~]+', 'good');
email_contents = regexprep(email_contents, '[($・・)/~~~]+', 'good');
email_contents = regexprep(email_contents, '[(@^^)/~~~ ]+', 'good');
email_contents = regexprep(email_contents, '[(T_T)/~~~]+', 'good');
email_contents = regexprep(email_contents, '[(ToT)/~~~]+', 'good');
email_contents = regexprep(email_contents, '[(V)o￥o(V)]+', 'bad');
email_contents = regexprep(email_contents, '[＼(~o~)／]+', 'good');
email_contents = regexprep(email_contents, '[＼(^o^)／]+', 'good');
email_contents = regexprep(email_contents, '[＼(-o-)／ ]+', 'good');
email_contents = regexprep(email_contents, '[ヽ(^。^)ノ]+', 'good');
email_contents = regexprep(email_contents, '[ヽ(^o^)丿]+', 'good');
email_contents = regexprep(email_contents, '[(*^0^*)]+', 'good');
email_contents = regexprep(email_contents, '[(*_*)]+', 'good');
email_contents = regexprep(email_contents, '[(*_*;]+', 'good');
email_contents = regexprep(email_contents, '[(+_+)]+', 'good');
email_contents = regexprep(email_contents, '[(@_@) ]+', 'good');
email_contents = regexprep(email_contents, '[(@_@。]+', 'good');
email_contents = regexprep(email_contents, '[(＠_＠;)]+', 'good');
email_contents = regexprep(email_contents, '[＼(◎o◎)／！]+', 'good');
email_contents = regexprep(email_contents, '[(*^^)v]+', 'good');
email_contents = regexprep(email_contents, '[(^^)v]+', 'good');
email_contents = regexprep(email_contents, '[(^_^)v]+', 'good');
email_contents = regexprep(email_contents, '[(＾▽＾)]+', 'good');
email_contents = regexprep(email_contents, '[（・∀・）]+', 'good');
email_contents = regexprep(email_contents, '[（　´∀｀）]+', 'good');
email_contents = regexprep(email_contents, '[（⌒▽⌒）]+', 'good');
email_contents = regexprep(email_contents, '[（＾ｖ＾）]+', 'good');
email_contents = regexprep(email_contents, '[（’-’*)]+', 'good');
email_contents = regexprep(email_contents, '[((d[-_-]b))]+', 'good');
email_contents = regexprep(email_contents, '[(^0_0^)]+', 'good');
email_contents = regexprep(email_contents, '[（●＾o＾●）]+', 'good');
email_contents = regexprep(email_contents, '[（＾ｖ＾）]+', 'good');
email_contents = regexprep(email_contents, '[（＾ｕ＾）]+', 'good');
email_contents = regexprep(email_contents, '[（＾◇＾）]+', 'good');
email_contents = regexprep(email_contents, '[( ^)o(^ ) ]+', 'good');
email_contents = regexprep(email_contents, '[(^O^)]+', 'good');
email_contents = regexprep(email_contents, '[(^o^)]+', 'good');
email_contents = regexprep(email_contents, '[(^○^)]+', 'good');
email_contents = regexprep(email_contents, '[)^o^(]+', 'good');
email_contents = regexprep(email_contents, '[(*^▽^*) ]+', 'good');
email_contents = regexprep(email_contents, '[(✿◠‿◠)]+', 'good');
email_contents = regexprep(email_contents, '[(-"-)]+', 'bad');
email_contents = regexprep(email_contents, '[(ーー゛)]+', 'bad');
email_contents = regexprep(email_contents, '[(^_^メ)]+', 'bad');
email_contents = regexprep(email_contents, '[(-_-メ)]+', 'bad');
email_contents = regexprep(email_contents, '[(｀´）]+', 'bad');
email_contents = regexprep(email_contents, '[(~_~メ)]+', 'bad');
email_contents = regexprep(email_contents, '[(－－〆)]+', 'bad');
email_contents = regexprep(email_contents, '[(・へ・)]+', 'bad');
email_contents = regexprep(email_contents, '[<`～´>]+', 'bad');
email_contents = regexprep(email_contents, '[<`ヘ´>]+', 'bad');
email_contents = regexprep(email_contents, '[(ーー;)]+', 'bad');
email_contents = regexprep(email_contents, '[（￣ー￣）]+', 'good');
email_contents = regexprep(email_contents, '[（￣□￣；）]+', 'good');
email_contents = regexprep(email_contents, '[°o°]+', 'good');
email_contents = regexprep(email_contents, '[°O°]+', 'good');
email_contents = regexprep(email_contents, '[:O]+', 'good');
email_contents = regexprep(email_contents, '[o_0]+', 'good');
email_contents = regexprep(email_contents, '[o.O]+', 'good');
email_contents = regexprep(email_contents, '[(o.o)]+', 'good');
email_contents = regexprep(email_contents, '[（*´▽｀*）]+', 'good');
email_contents = regexprep(email_contents, '[(*°∀°)=3]+', 'good');
email_contents = regexprep(email_contents, '[（　ﾟ Дﾟ）]+', 'bad');
email_contents = regexprep(email_contents, '[（゜◇゜）]+', 'bad');
email_contents = regexprep(email_contents, '[(*￣m￣)]+', 'bad');
email_contents = regexprep(email_contents, '[ヽ（´ー｀）┌]+', 'good');
email_contents = regexprep(email_contents, '[¯\_(ツ)_/¯]+', 'good');
email_contents = regexprep(email_contents, '[(´･ω･`)]+', 'bad');
email_contents = regexprep(email_contents, '[(‘A`)]+', 'bad');
email_contents = regexprep(email_contents, '[(*^3^)/~☆]+', 'good');
email_contents = regexprep(email_contents, '[.....φ(・∀・＊)]+', 'good');
email_contents = regexprep(email_contents, '[キタ━━━(゜∀゜)━━━!!!!! ]+', 'good');
email_contents = regexprep(email_contents, '[＿|￣|○]+', 'bad');
email_contents = regexprep(email_contents, '[STO]+', 'bad');
email_contents = regexprep(email_contents, '[OTZ]+', 'bad');
email_contents = regexprep(email_contents, '[OTL]+', 'bad');
email_contents = regexprep(email_contents, '[orz]+', 'bad');
email_contents = regexprep(email_contents, '[(╯°□°）╯︵]+', 'bad');
email_contents = regexprep(email_contents, '[┻━┻ ┬──┬]+', 'bad');
email_contents = regexprep(email_contents, '[¯\_(ツ)]+', 'bad');
email_contents = regexprep(email_contents, '[┻━┻]+', 'bad');
email_contents = regexprep(email_contents, '[︵ヽ(`Д´)ﾉ︵ ]+', 'bad');
email_contents = regexprep(email_contents, '[┻━┻]+', 'bad');
email_contents = regexprep(email_contents, '[┬─┬ノ( º _ ºノ)]+', 'bad');
email_contents = regexprep(email_contents, '[(ノಠ益ಠ)ノ彡┻━┻]+', 'bad');

% Handle URLS
% Look for strings starting with http:// or https://
%email_contents = regexprep(email_contents, ...
               %           '(http|https)://[^\s]*', 'httpaddr');

% Handle Email Addresses
% Look for strings with @ in the middle
%email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');

% Handle $ sign
%email_contents = regexprep(email_contents, '[$]+', 'dollar');


% tokenizer 

l = 0;

while ~isempty(email_contents)

    % Tokenize and also get rid of any punctuation
    [str, email_contents] = ...
       strtok(email_contents, ...
              [' @$/#.:&*+=[](){}>_<;%' char(10) char(13)]);
   
    % Remove any non alphanumeric characters
    str = regexprep(str, '[^a-zA-Z0-9]', '');

    % Stem the word 
    % Stemmer worked but was implemented too late
    % into development to work with previous code/functions
    %try str = porterStemmer(strtrim(str)); 
    %catch str = ''; continue;
    %end;

    % Skip the word if it is too short
    if length(str) < 1
       continue;
    end

    % Look up the word in the dictionary and add to word_indices if
    % found
    % ====================== YOUR CODE HERE ======================
    % Instructions: Fill in this function to add the index of str to
    %               word_indices if it is in the vocabulary. At this point
    %               of the code, you have a stemmed word from the email in
    %               the variable str. You should look up str in the
    %               vocabulary list (vocabList). If a match exists, you
    %               should add the index of the word to the word_indices
    %               vector. Concretely, if str = 'action', then you should
    %               look up the vocabulary list to find where in vocabList
    %               'action' appears. For example, if vocabList{18} =
    %               'action', then, you should add 18 to the word_indices 
    %               vector (e.g., word_indices = [word_indices ; 18]; ).
    % 
    % Note: vocabList{idx} returns a the word with index idx in the
    %       vocabulary list.
    % 
    % Note: You can use strcmp(str1, str2) to compare two strings (str1 and
    %       str2). It will return 1 only if the two strings are equivalent.
    %
    
    %word_indices = [word_indices strmatch(str, vocabList, 'exact')];

    [found, index] = ismember(str, vocabList);
	if (found)
		word_indices = [word_indices; index];
	end;
    
    % =============================================================

end

% Print footer
%fprintf('\n\n=========================\n');

end
