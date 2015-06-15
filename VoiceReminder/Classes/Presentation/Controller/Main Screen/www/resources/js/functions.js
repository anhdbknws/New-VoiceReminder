var ui_currentDate;
var ui_nextDate;
var ui_prevDate;
var direction;	
var DanhNgon_data = "{\"Node\":[{\"D\":\"Tình yêu của các chàng trai không nằm ở trái tim mà nằm ở đôi mắt.\",\"T\":\"Shakespear\"},{\"D\":\"Khi yêu, người ta thấy sự xa cách và thời gian chẳng là gì cả.\",\"T\":\"Afred de Musset\"},{\"D\":\"Tình yêu nâng cao con người thoát khỏi sự tầm thường.\",\"T\":\"Pascal\"},{\"D\":\"Đang thật yêu bỗng căm ghét là còn yêu một cách âm thầm tha thiết.\",\"T\":\"De Saidéry\"},{\"D\":\"Chân lý cuối cùng của ở cuộc đời này là tình yêu có nghĩa là sống và sống là yêu.\",\"T\":\"Voltaire\"},{\"D\":\"Một người đang yêu có hai trạng thái: hoặc là không nghi ngờ gì hết, hai là nghi ngờ tất cả.\",\"T\":\"Balzac\"},{\"D\":\"Sự đau khổ làm cho tâm hồn thêm nhẹ nhàng và thanh cao.\",\"T\":\"Lamartin\"},{\"D\":\"Ngôn ngữ của tình yêu nằm trong đôi mắt.\",\"T\":\"Phineas Fletcher\"},{\"D\":\"Ai khổ vì yêu hãy yêu hơn nữa. Chết vì yêu là sống trong tình yêu.\",\"T\":\"Victor Hugo\"},{\"D\":\"Tình yêu chỉ sống được trong đau khổ, chỉ sống trong hạnh phúc tình yêu sẽ chết non.\",\"T\":\"De Gurardin\"},{\"D\":\"Yêu vì mục đích được yêu là con người, nhưng yêu vì mục đích yêu là thiên thần.\",\"T\":\"Lamartin\"},{\"D\":\"Thà rằng yêu em mà đau khổ còn hơn cả 1 đời ta không biết em.\",\"T\":\"Guilleragues\"},{\"D\":\"Hạnh phúc lớn nhất trên đời này là tin rằng mình được yêu.\",\"T\":\"Victor Hugo\"},{\"D\":\"Tất cả những gì anh yêu sẽ mất đi một nửa thú vị nếu không có em để cùng chia sẻ.\",\"T\":\"Clara ortera\"},{\"D\":\"Thời gian không dành cho tình yêu là thời gian lãng phí.\",\"T\":\"Tasso\"},{\"D\":\"Thật đau khổ cho kẻ nào vào lúc bắt đầu yêu đã không tin rằng tình yêu đó sẽ là vĩnh cửu.\",\"T\":\"C.Constan\"},{\"D\":\"Muốn yêu cho ra yêu một người phụ nữ, ta phải yêu nàng như là nàng phải chết ngày mai.\",\"T\":\"Tục ngữ ả rập\"},{\"D\":\"Không có gì cao thượng hơn tình yêu nằm trong những trái tim trong sáng.\",\"T\":\"Ngạn ngữ Pháp\"},{\"D\":\"Si mê thì dễ, yêu mới khó.\",\"T\":\"Maral Aymi\"},{\"D\":\"Ta không yêu một người con gái vì những lời nàng nói. Ta yêu những lời nàng nói vì ta yêu nàng.\",\"T\":\"A. Maurois\"},{\"D\":\"Ai yêu mãnh liệt kẻ ấy ít lời.\",\"T\":\"Caxtilônê\"},{\"D\":\"Không gì diễn tả được nỗi đau do cái ghen đem đến cho con tim chưa nói được lời tỏ tình.\",\"T\":\"Mme De Lafayette\"},{\"D\":\"Người ghen luôn tìm thấy nhiều điều hơn ý mình muốn tìm.\",\"T\":\"Moliere\"},{\"D\":\"Trong sự ghen tuông tự ái đóng vai trò quan trọng hơn là ái tình.\",\"T\":\"Rochefoucauld\"},{\"D\":\"Bạn muốn vợ bạn ngoan ngoãn không? Đừng khi nào có những ngờ vực ghen tuông.\",\"T\":\"La brun\"},{\"D\":\"Kẻ nào không ghen là không yêu.\",\"T\":\"St Augustin\"},{\"D\":\"Xa cách ngắn ngủi khích động say mê nhưng xa cách lâu dài giết chết say mê.\",\"T\":\"Charles De Saint\"},{\"D\":\"Sự dối trá sẽ giết chết tình yêu, song chính sự thẳng thắn sẽ giết chết nó trước.\",\"T\":\"Hemingway\"},{\"D\":\"Không có tình yêu vĩnh cửu mà chỉ có những giây phút vĩnh cửu của tình yêu.\",\"T\":\"Ngạn ngữ\"},{\"D\":\"Bạn hãy yêu tự do hơn tất cả và làm điều thiện ở bất cứ nơi nào có thể.\",\"T\":\"V.Beethoven\"},{\"D\":\"Danh dự là sự hòa hợp tự nhiên giữa việc tôn trọng mọi người và tự tôn trọng chính mình.\",\"T\":\"W. Shakespear\"},{\"D\":\"Lý trí có thể mách bảo ta điều phải tránh, còn con tim sẽ chỉ cho ta biết điều phải làm.\",\"T\":\"Joubert\"},{\"D\":\"Cái gì xuất phát từ trái tim sẽ đi đến trái tim.\",\"T\":\"Piêt\"},{\"D\":\"Không có ngày mai nào lại không kết thúc, không có sự đau khổ nào lại không có lối ra.\",\"T\":\"Rsoutheell\"},{\"D\":\"Hãy làm tròn mỗi công việc của đời mình như thể đó là công việc cuối cùng.\",\"T\":\"Marc aurele\"},{\"D\":\"Tôi thường hối tiếc vì mình đã mở mồm chứ không bao giờ…vì mình đã im lặng.\",\"T\":\"Philippe de Commynes\"},{\"D\":\"Cách khéo nhất để làm vừa lòng ai đó là xin họ lời khuyên.\",\"T\":\"Odove Primex\"},{\"D\":\"Nếu có hai người cùng sống với nhau hòa thuận nên tin trong đó ít nhất một người tốt.\",\"T\":\"Ngạn ngữ Angiêri\"},{\"D\":\"Đừng mua thứ hữu ích mà hãy mua thứ cần thiết.\",\"T\":\"Caton Censeur\"},{\"D\":\"Người đáng nói mà mình không nói là mất người. Người không đáng nói mà mình nói là mất lời.\",\"T\":\"Khổng Tử\"},{\"D\":\"Người xin bố thí đỏ mặt một lần, kẻ từ chối không bố thí đỏ mặt hai lần.\",\"T\":\"Ngạn ngữ Thổ nhĩ Kỳ\"},{\"D\":\"Hoài nghi chính mình là điều phải làm đầu tiên của người quân tử.\",\"T\":\"P. Nicole\"},{\"D\":\"Đừng ném lời cho gió, nếu không hay biết gió thổi về đâu.\",\"T\":\"N. Ghenin\"},{\"D\":\"Nếu sự khiêm nhường của bạn khiến mọi người để ý thì hẳn có chút đó chẳng bình thường.\",\"T\":\"M. Ghenin.\"},{\"D\":\"Người không biết tươi cười sẽ không biết cách mở ra những cánh cửa.\",\"T\":\"Ngạn Ngữ Trung Quốc\"},{\"D\":\"Đừng để đến ngày mai những việc gì anh có thể làm hôm nay.\",\"T\":\"Lord Chesterfield\"},{\"D\":\"Cho quí hơn nhận song cái giếng sâu nhất cũng cạn nếu không được uống nước đó sao?.\",\"T\":\"H.A. Kromer\"},{\"D\":\"Những gì ta cho đi một cách thật lòng thì mãi mãi là của ta.\",\"T\":\"Geoges Granville\"},{\"D\":\"Thiếu thận trọng gây nhiều tai hại hơn thiếu hiểu biết.\",\"T\":\"Franklin\"},{\"D\":\"Hãy suy nghĩ tất cả những gì bạn nói nhưng đừng nói tất cả những gì bạn nghĩ.\",\"T\":\"Delarme\"},{\"D\":\"Con ong được ca tụng vì nó làm việc không phải cho chính mình nhưng cho tất cả.\",\"T\":\"Saint J.Chrysistome\"},{\"D\":\"Đừng bao giờ khiêm tốn với kẻ kiêu căng, cũng đừng bao giờ kiêu căng với người khiêm tốn.\",\"T\":\"Jeffecson\"},{\"D\":\"Sự ngắn gọn là linh hồn của trí khốn sắc sảo.\",\"T\":\"Shakespear\"},{\"D\":\"Đầu hàng cám rỗ là hành động của thú tính, chiến thắng nó mới là con người.\",\"T\":\"Waterstone\"},{\"D\":\"Hãy hiền dịu khoan dung với hết mọi người trừ bản thân mình.\",\"T\":\"Joubert\"},{\"D\":\"Nếu ai nói xấu bạn mà nói đúng thì hãy sửa mình đi. Nếu họ nói bậy thì bạn hãy cười thôi.\",\"T\":\"Epictete\"},{\"D\":\"Ai không biết nghe, tất không biết nói chuyện.\",\"T\":\"Giarardin\"},{\"D\":\"Mỗi khi khuyên ai bất cứ điều gì thì nên thật vắn tắt.\",\"T\":\"Horace\"},{\"D\":\"Phải biết mở cửa lòng mình trước mới hy vọng mở được lòng người khác.\",\"T\":\"Pasquier Quesnel\"},{\"D\":\"Điều gì anh muốn người ta làm cho anh, anh hãy làm cho người ta.\",\"T\":\"Kinh Thánh\"},{\"D\":\"Đôi khi phải nhượng bộ mà thừa nhận rằng củ cải là củ lê.\",\"T\":\"Ngạn ngữ Đức\"},{\"D\":\"Muốn uốn cây cong cho thẳng lại, ta uốn cong nó theo chiều ngược lại.\",\"T\":\"Montaigne\"},{\"D\":\"Không có gì nguy hiểm bằng lời khuyên tốt đi kèm với gương xấu.\",\"T\":\"De Scudery\"},{\"D\":\"Khuyên răn thay cho giận dữ, mỉm cười thay cho khinh bỉ.\",\"T\":\"Epiquya\"},{\"D\":\"Bao giờ cũng nên có nhiều trí tuệ hơn lòng tự ái.\",\"T\":\"Epiquya\"},{\"D\":\"Không bao giờ làm phiền người khác về những việc mình có thể làm được.\",\"T\":\"Jeffecson\"},{\"D\":\"Yêu mọi người, tin vài người và đừng xúc phạm đến ai.\",\"T\":\"Shakespear\"},{\"D\":\"Những người mạnh không dùng lời lẽ lăng mạ. Họ mỉm cười.\",\"T\":\"L.Leonop\"},{\"D\":\"Ngoại giao là khoa học của sự nhượng bộ.\",\"T\":\"A.Musset\"},{\"D\":\"Nghệ thuật sống với nhau chính là nghệ thuật giữ khoảng cách.\",\"T\":\"O. Wide\"},{\"D\":\"Phép lịch sự là quy tắc chi phối các mối quan hệ, đó là nghệ thuật của lòng vị tha.\",\"T\":\"Erasme\"},{\"D\":\"Ai vâng lời liều, hứa liều, tất nhiên khó lòng đúng hẹn.\",\"T\":\"Lão Tử\"},{\"D\":\"Bạn bè tốt thanh toán tiền của họ một cách nhanh chóng.\",\"T\":\"Tục ngữ Trung Quốc\"},{\"D\":\"Câu trả lời gọn nhất là hành động.\",\"T\":\"Goethe\"},{\"D\":\"Đi vòng mà đến đích còn hơn đi thẳng mà ngã đau.\",\"T\":\"Tục ngữ Anh\"},{\"D\":\"Đừng bao giờ bắt buộc người khác làm những gì mà họ không muốn.\",\"T\":\"Tục ngữ Anh\"},{\"D\":\"Đừng bao giờ ném bùn vào người khác. Bạn có thể ném trật và tay bạn chắc chắn bị bẩn.\",\"T\":\"Joseph Parker\"},{\"D\":\"Đôi tai là lối vào của trái tim.\",\"T\":\"Voltaire\"},{\"D\":\"Hãy vội nghe và chậm trả lời.\",\"T\":\"Ben Sira\"},{\"D\":\"Hãy nói nếu bạn có những lời lẽ mạnh hơn, nếu không, hãy im lặng.\",\"T\":\"Euripide\"},{\"D\":\"Lời nói khéo còn hơn cả hùng biện.\",\"T\":\"Bacon\"},{\"D\":\"Một lời xin lỗi vụng về vẫn tốt hơn im lặng.\",\"T\":\"Stephen Gosson\"},{\"D\":\"Người đọc biết nhiều nhưng người quan sát còn biết nhiều hơn.\",\"T\":\"A. Dumas con\"},{\"D\":\"Phải biết chăm chú lắng nghe và khuyến khích người khác nói về họ.\",\"T\":\"D. Canergie\"},{\"D\":\"Phải kính trọng con người! Đừng thương hại nó.\",\"T\":\"M.Gorki\"},{\"D\":\"Điều oái oăm là, nếu bạn không muốn liều mất cái gì thì bạn còn mất nhiều hơn.\",\"T\":\"Erica Jong\"},{\"D\":\"Không một người nào đã từng cười hết mình và cười xả láng lại đồng thời là người xấu xa.\",\"T\":\"Thomas Carlyle\"},{\"D\":\"Thói quen làm những gì tốt đẹp nhất trần thế trở nên tầm thường.\",\"T\":\"Bade Rvew\"},{\"D\":\"Sự quá thân mật và sỗ sàng đều làm phai nhạt tình yêu hơn là tình bạn.\",\"T\":\"Rôchepede\"},{\"D\":\"Người ta thường khen chỉ để được khen. Từ chối lời khen là muốn được khen gấp hai lần.\",\"T\":\"La Rochefoucould\"},{\"D\":\"Khi bạn không thể thực hiện những gì ao ước, bạn nên ao ước những gì có thể làm.\",\"T\":\"Terence\"},{\"D\":\"Không ai tán thưởng một cây đang trổ hoa.\",\"T\":\"Harold Philips\"},{\"D\":\"Hãy tin một nửa những gì anh thấy tận mắt và đừng tin những gì anh nghe được.\",\"T\":\"D. Crai\"},{\"D\":\"Đừng bao giờ khuyên răn ai giữa đám đông.\",\"T\":\"Tục ngữ A rập\"},{\"D\":\"Không nên nói tất cả những gì bạn biết, nhưng bao giờ cũng phải biết những gì mà bạn nói.\",\"T\":\"M. Claudius\"},{\"D\":\"Kẻ nào gian dối trong việc nhỏ thì sẽ gian dối trong việc lớn.\",\"T\":\"Kinh thánh\"},{\"D\":\"Đừng đọc gì anh không muốn nhớ và đừng nhớ gì anh không định dùng.\",\"T\":\"G. Blecki\"},{\"D\":\"Mình thế nào mà không dám tỏ ra như thế là mình khinh mình.\",\"T\":\"Mat-xi-lông\"},{\"D\":\"Kẻ nào không biết giữ cái nhỏ sẽ mất cái lớn.\",\"T\":\"Mênanđơ\"},{\"D\":\"Tướng giỏi sau khi thắng trận không cần ai khen và cũng không cần ai biết đến công lao.\",\"T\":\"Tôn tử\"},{\"D\":\"Dùng người như dùng gỗ, đừng vì một vài chỗ mục mà bỏ cả cây lớn.\",\"T\":\"Khổng Tử\"},{\"D\":\"Đừng hoãn lại một việc gì về sau, bởi vì về sau bạn cũng không gặp dễ dàng hơn.\",\"T\":\"Jăngpon\"},{\"D\":\"Muốn điều khiển phải biết người. Muốn biết người phải hiểu mình trước đã.\",\"T\":\"Đitơcuppơ\"},{\"D\":\"Anh cho những gì anh có là cho rất ít, nhưng khi anh phải hi sinh anh mới cho một cách thực sự.\",\"T\":\"Gibran\"},{\"D\":\"Cho mượn ít, tạo ra một con nợ. Cho mượn nhiều, tạo ra một kẻ thù.\",\"T\":\"La Bruyere\"},{\"D\":\"Hỏi một câu, chỉ dốt nát trong chốc lát. Không dám hỏi sẽ dốt nát suốt đời.\",\"T\":\"DN phương Tây\"},{\"D\":\"Nên tập thói quen tìm sự thật trong các việc nhỏ nếu không sẽ bị lừa trong các việc lớn.\",\"T\":\"Vontaire\"},{\"D\":\"Nếu bạn muốn đi qua cuộc đời không phiền toái thì chẳng nên bỏ đá vào túi mà đeo.\",\"T\":\"V. Shemtchisnikov.\"},{\"D\":\"Thiên đường ở chính trong ta. Địa ngục cũng do lòng ta mà có.\",\"T\":\"Chúa Jésus\"},{\"D\":\"Hãy can đảm mà sống bởi vì ai cũng phải chết một lần.\",\"T\":\"Cantauzene\"},{\"D\":\"Đừng đi qua thời gian mà không để lại dấu vết.\",\"T\":\"Không rõ\"},{\"D\":\"Nhiều người đã khóc khi chào đời, phàn nàn khi đang sống và chán chường khi tắt thở.\",\"T\":\"Không rõ\"},{\"D\":\"Bốn mươi là tuổi già của lớp trẻ, năm mươi là tuổi trẻ của lớp già.\",\"T\":\"Không rõ\"},{\"D\":\"Bao giờ ta cũng phải luôn luôn có một nơi nào để đến.\",\"T\":\"Không rõ\"},{\"D\":\"Những người vui hưởng cuộc sống thì không bao giờ là kẻ thất bại.\",\"T\":\"Không rõ\"},{\"D\":\"Chúng ta hãy cố gắng để chỉ chết một lần thôi.\",\"T\":\"Không rõ\"},{\"D\":\"Đời người được đo bằng tư tưởng và hành động chứ không phải bằng thời gian.\",\"T\":\"Emerson\"},{\"D\":\"Cuộc đời ngắn ngủi không cho phép ta hy vọng quá xa.\",\"T\":\"Ngạn ngữ Latin\"},{\"D\":\"Đừng sống theo điều ta mong muốn. Hãy sống theo điều ta có thể.\",\"T\":\"Ngạn ngữ Latin\"},{\"D\":\"Người muốn đi thì số phận dẫn đi. Người không muốn đi thì số phận kéo lê.\",\"T\":\"Ngạn ngữ Latin\"},{\"D\":\"Mục đích tối trọng của đời người không phải là sự hiểu biết mà là hành động.\",\"T\":\"A. Haoxlay\"},{\"D\":\"Một người nào đó đã chết điều đó chưa chắc chắn đã phải người ấy đã từng sống.\",\"T\":\"X.Letx\"},{\"D\":\"Khi con người ta sống chỉ vì mình thì trở thành thừa đối với những người còn lại.\",\"T\":\"I.Rađep\"},{\"D\":\"Con người có thể chết được là để anh ta biết quý thời gian.\",\"T\":\"I.Rađep\"},{\"D\":\"Thời gian không đo lường bằng năm tháng mà bằng những gì chúng ta làm được.\",\"T\":\"H.Cason\"},{\"D\":\"Cuộc sống là nghĩa vụ ngay cả trong trường hợp nó chỉ diễn ra trong khoảnh khắc.\",\"T\":\"W.Gớt\"},{\"D\":\"Người ta còn sống mà làm gì, khi mà sau gót giày, gió quét sạch ngay dấu tích cuối cùng của ta.\",\"T\":\"S.Xvâygơ\"},{\"D\":\"Khi không còn ai ghen tị với bạn thì hãy xem lại liệu mình đã sống đúng chưa.\",\"T\":\"M.Ghenin\"},{\"D\":\"Chỉ có cuộc sống vì người khác mới là cuộc sống đáng quý.\",\"T\":\"A.Einstein\"},{\"D\":\"Điều quan trọng không phải chúng ta sống được bao lâu mà chúng ta phải sống như thế nào.\",\"T\":\"Bailey\"},{\"D\":\"Chúng ta có bốn mươi triệu lý do về sự thất bại nhưng không có một lời bào chữa nào ..\",\"T\":\"C.Xanbot\"},{\"D\":\"Hãy học cách sống vượt thành công của người khác.\",\"T\":\"A.Fuirstenbeg\"},{\"D\":\"Thành công chỉ đến khi bạn làm việc tận tâm và luôn nghĩ đến những điều tốt đẹp.\",\"T\":\"A schwarzenegger\"},{\"D\":\"Không có nghèo gì bằng không có tài, không có gì hèn bằng không có chí.\",\"T\":\"Uông Cách\"},{\"D\":\"Chưa thử sức thì không bao giờ biết hết năng lực của mình. .\",\"T\":\"Goethe\"},{\"D\":\"Những ý tưởng cao đẹp là vốn liếng chỉ sinh lợi trong tay những người tài năng.\",\"T\":\"D. Rivarol.\"},{\"D\":\"Đừng để đến ngày mai những việc gì anh có thể làm hôm nay.\",\"T\":\"Lord Chesterfield\"},{\"D\":\"Nếu không vấp phải một trở ngại nào nữa, tức là bạn đã đi chệch đường rồi đó.\",\"T\":\"M. Ghenin\"},{\"D\":\"Kẻ nào không muốn cúi xuống lượm một cây kim thì không đáng có một đồng bạc.\",\"T\":\"Ngạn ngữ Anh\"},{\"D\":\"Thành công là một cuộc hành trình chứ không phải là điểm đến.\",\"T\":\"A.Moravia\"},{\"D\":\"Những người lười biếng sẽ không bao giờ biết rằng chỉ trong sự lao động mới có sự nghỉ ngơi.\",\"T\":\"Marius Grout\"},{\"D\":\"Người ta biết đến cái cây nhờ quả của nó chứ không nhờ dễ của nó.\",\"T\":\"Không rõ\"},{\"D\":\"Giờ tăm tối nhất là trước lúc rạng đông.\",\"T\":\"Không rõ\"},{\"D\":\"Khẩu hiệu dẫn đến thành công là :” áp dụng – thích nghi – Cải tiến”.\",\"T\":\"Không rõ\"},{\"D\":\"Hỏi bất kỳ kẻ thất bại nào bạn cũng nhận được câu trả lời: Thành công là nhờ may mắn.\",\"T\":\"Không rõ\"},{\"D\":\"Nhiều người làm việc chỉ vì họ phải làm việc thì sẽ không bao giờ tiến bước.\",\"T\":\"Không rõ\"},{\"D\":\"Bao giờ ta cũng phải luôn luôn có một nơi nào để đến.\",\"T\":\"Không rõ\"},{\"D\":\"Chỉ có thành công duy nhất – đó là có khả năng sống cuộc sống của mình theo cách mình muốn.\",\"T\":\"Không rõ\"},{\"D\":\"Những người vui hưởng cuộc sống thì không bao giờ là kẻ thất bại.\",\"T\":\"Không rõ\"},{\"D\":\"Ngu dốt không đáng thẹn bằng thiếu ý chí học hỏi.\",\"T\":\"B.Franklin\"},{\"D\":\"Tôi còn những lời hứa phải giữ, những dặm đường phải đi trước khi ngủ.\",\"T\":\"Hậu Hán Thơ\"},{\"D\":\"Thành đạt không phải ở người giúp đỡ mà chính do lòng tự tin.\",\"T\":\"A. Braham Lincoln\"},{\"D\":\"Hãy làm tròn mỗi công việc của đời mình như thể đó là công việc cuối cùng.\",\"T\":\"Marc aurele\"},{\"D\":\"Đường đi khó không phải vì ngăn sông cách núi . Mà khó vì lòng người ngại núi e sông.\",\"T\":\"Nguyễn Thái Học\"},{\"D\":\"Người hoàn thiện nhất là người đã giúp ích cho đồng loại nhiều nhất.\",\"T\":\"Kinh coran\"},{\"D\":\"Không có gì hèn cho bằng khi ta nghĩ bạo mà không dám làm.\",\"T\":\"Jean Ronstard\"},{\"D\":\"Nếu tôi biết điều gì tôi muốn tôi sẽ biết hơn điều gì tôi làm.\",\"T\":\"Benjamin Constant\"},{\"D\":\"Các yếu tố của nghệ thuật học tập là ý chí, trật tự và thời gian.\",\"T\":\"M. Prévost\"},{\"D\":\"Con ong được ca tụng vì nó làm việc không phải cho chính mình nhưng cho tất cả.\",\"T\":\"Saint J.Chrysistome\"},{\"D\":\"Chiến thắng bản thân là chiến thắng hiển hách nhất.\",\"T\":\"Platon\"},{\"D\":\"Kẻ hoang phí sẽ là kẻ ăn mày trong tương lai. Kẻ tham lam là kẻ ăn mày suốt đời.\",\"T\":\"Ngạn ngữ Balan\"},{\"D\":\"Học trò xoàng xĩnh là học trò không vượt được thầy.\",\"T\":\"Léonard de Vinci\"},{\"D\":\"Ba cái nền tảng của học vấn là: nhận xét nhiều, từng trải nhiều và học tập nhiều.\",\"T\":\"Catherall\"},{\"D\":\"Ai than thở không bao giờ có thời gian, người ấy làm được ít việc nhất.\",\"T\":\"G.Lichtenberg\"},{\"D\":\"Câu trả lời gọn nhất là hành động.\",\"T\":\"Goethe\"},{\"D\":\"Đường tuy gần không đi không bao giờ đến, việc tuy nhỏ không làm chẳng bao giờ nên.\",\"T\":\"Tuân Tử\"},{\"D\":\"Đi vòng mà đến đích còn hơn đi thẳng mà ngã đau.\",\"T\":\"Tục ngữ Anh\"},{\"D\":\"Đời người được đo bằng tư tưởng và hành động chứ không phải bằng thời gian.\",\"T\":\"Emerson\"},{\"D\":\"Lý tưởng ấp ủ trong tâm trí sẽ tạo nên những hành vi phù hợp với lý tưởng.\",\"T\":\"E. Hubbart\"},{\"D\":\"Người anh hùng vĩ đại nhất là người làm chủ được những ước mơ của mình.\",\"T\":\"Bhartrihary\"},{\"D\":\"Làm việc đừng quá trông đợi vào kết quả, nhưng hãy mong cho mình làm được hết sức mình.\",\"T\":\"Anita Hill\"},{\"D\":\"Dù người ta có nói với bạn điều gì đi nữa, hãy tin rằng cuộc sống là điều kỳ diệu và đẹp đẽ.\",\"T\":\"Pautopxki\"},{\"D\":\"Một nửa sức khỏe của con người là trong tâm lý.\",\"T\":\"S. Aleksievist\"},{\"D\":\"Có niềm tin mà không hành động, niềm tin đó có thành khẩn hay không?.\",\"T\":\"A.Maurois\"},{\"D\":\"Ngu dốt không đáng thẹn bằng thiếu ý chí học hỏi.\",\"T\":\"B.Franklin\"},{\"D\":\"Nếu bạn muốn đi qua cuộc đời không phiền toái thì chẳng nên bỏ đá vào túi mà đeo.\",\"T\":\"V. Shemtchisnikov.\"},{\"D\":\"Lòng tin không phải là khởi đầu mà là kết quả của mọi nhận thức.\",\"T\":\"W. Goethe.\"},{\"D\":\"Thế giới là 10%do mình làm ra và 90% do mình nhìn nhận.\",\"T\":\"A. Berlin.\"},{\"D\":\"Thiên đường ở chính trong ta. Địa ngục cũng do lòng ta mà có.\",\"T\":\"Chúa Jésus\"},{\"D\":\"Tôi thường hối tiếc vì mình đã mở mồm chứ không bao giờ…vì mình đã im lặng.\",\"T\":\"Philippe de Commynes\"},{\"D\":\"Đừng bao giờ đóng sầm cửa lại; có thể bạn muốn quay trở lại vào đấy.\",\"T\":\"J.C.Hare\"},{\"D\":\"Bạn sẽ không bao giờ trở thành nhà tư tưởng nếu bạn không biết cười.\",\"T\":\"Không rõ\"},{\"D\":\"Hãy can đảm mà sống bởi vì ai cũng phải chết một lần.\",\"T\":\"Không rõ\"},{\"D\":\"Khiêm tốn bao nhiêu cũng chưa đủ, tự kiêu một chút cũng là nhiều.\",\"T\":\"Karl Marx\"},{\"D\":\"Đừng bao giờ khiêm tốn với kẻ kiêu căng, cũng đừng bao giờ kiêu căng với người khiêm tốn.\",\"T\":\"Jeffecson\"},{\"D\":\"Không có gì hèn cho bằng khi ta nghĩ bạo mà không dám làm.\",\"T\":\"Jean Ronstard\"},{\"D\":\"Những kẻ trí tuệ tầm thường hay lên án những gì vượt quá tầm hiểu biết của họ.\",\"T\":\"La Rochefoucould\"},{\"D\":\"Nếu ai nói xấu bạn mà nói đúng thì hãy sửa mình đi. Nếu họ nói bậy thì bạn hãy cười thôi.\",\"T\":\"Epictete\"},{\"D\":\"Ai không biết nghe, tất không biết nói chuyện.\",\"T\":\"Giarardin\"},{\"D\":\"Phải biết mở cửa lòng mình trước mới hy vọng mở được lòng người khác.\",\"T\":\"Pasquier Quesnel\"},{\"D\":\"Cái nhìn vui vẻ biến một bữa ăn thành một bữa tiệc.\",\"T\":\"Herbert\"},{\"D\":\"Bao giờ cũng nên có nhiều trí tuệ hơn lòng tự ái.\",\"T\":\"Epiquya\"},{\"D\":\"Luôn nghĩ rằng tất cả những việc ta thích làm đều không có vẻ nặng nhọc.\",\"T\":\"Jeffecson\"},{\"D\":\"Sở thích mạnh nhất của nhân loại là muốn được người khác cho mình là người quan trọng.\",\"T\":\"John Deway\"},{\"D\":\"Im lặng và khiêm tốn là đặc tính rất quý trong cuộc đàm thoại.\",\"T\":\"Monteigne\"},{\"D\":\"Bạn nghi ngờ ai tùy bạn, nhưng đừng nghi ngờ bản thân mình.\",\"T\":\"Plutarch\"},{\"D\":\"Điều oái oăm là, nếu bạn không muốn liều mất cái gì thì bạn còn mất nhiều hơn.\",\"T\":\"Erica Jong\"},{\"D\":\"Không một người nào đã từng cười hết mình và cười xả láng lại đồng thời là người xấu xa.\",\"T\":\"Thomas Carlyle\"},{\"D\":\"Đừng tự hạ giá bạn. Tất cả những gì bạn có đã làm nên nhân cách của bạn.\",\"T\":\"Janis Joplin\"},{\"D\":\"Không có điều gì trên đời khiến chúng ta phải sợ. Chỉ có những điều chúng ta cần phải hiểu.\",\"T\":\"Marie Curie\"},{\"D\":\"Cố chấp và bảo thủ là bằng chứng chắc chắn nhất của sự ngu si.\",\"T\":\"J.b. Bactông\"},{\"D\":\"Phụ nữ chỉ đẹp thật sự khi nào họ đẹp cho một người đàn ông nào đó.\",\"T\":\"Michel Deon\"},{\"D\":\"Đối với người phụ nữ, yên lặng cũng là một thứ trang sức.\",\"T\":\"Không rõ\"},{\"D\":\"Người phụ nữ cười khi có thể cười nhưng muốn khóc thì lúc nào cũng được.\",\"T\":\"Ngạn ngữ Pháp\"},{\"D\":\"Không có phụ nữ xấu, chỉ có phụ nữ không biết làm đẹp.\",\"T\":\"La Bruyere\"},{\"D\":\"Tất cả mọi sự bí ẩn của thế giới này đều không thể sánh nổi với sự bí ẩn của người phụ nữ.\",\"T\":\"Vladimir Lobanok\"},{\"D\":\"Ta không yêu một người con gái vì những lời nàng nói. Ta yêu những lời nàng nói vì ta yêu nàng.\",\"T\":\"A. Maurois\"},{\"D\":\"Sắc đẹp tự nó đủ thuyết phục đôi mắt của người đàn ông mà chẳng cần nhà hùng biện.\",\"T\":\"Tục ngữ\"},{\"D\":\"Người phụ nữ đẹp là thiên đường của đôi mắt.\",\"T\":\"Không rõ\"},{\"D\":\"Không phải những người đẹp là người hạnh phúc, mà những người hạnh phúc là những người đẹp.\",\"T\":\"Khuyết Danh.\"},{\"D\":\"Nơi người phụ nữ quyến rũ lòng người nhất không phải là cái đẹp mà là sự cao quý.\",\"T\":\"Eunpide\"},{\"D\":\"Không có gì thật cao quý và đáng kính trọng bằng lòng chung thủy.\",\"T\":\"Cicero\"},{\"D\":\"Một người phụ nữ ghen tin tưởng vào mọi thứ do cảm xúc của nàng đưa đến.\",\"T\":\"Jhon gay\"},{\"D\":\"Phụ nữ chỉ nhớ người đàn ông làm cho họ cười. Đàn ông chỉ nhớ người phụ nữ làm cho họ khóc.\",\"T\":\"De Regnier\"},{\"D\":\"Điều đáng sợ nhất ở người phụ nữ là tính ích kỷ.\",\"T\":\"G. Fêdơ\"},{\"D\":\"Phụ nữ luôn sẵn sàng hy sinh, nếu bạn cho họ cơ hội. Sở trường của họ chính là nhường nhịn.\",\"T\":\"W.S.Moom\"},{\"D\":\"Đàn ông đau xót với cái họ mất, còn phụ nữ với cái mà họ không thể nhận được.\",\"T\":\"D.BilingX\"},{\"D\":\"Tôi thích người đàn ông có tương lai và người phụ nữ có quá khứ.\",\"T\":\"O.Uaind\"},{\"D\":\"Người phụ nữ dễ tha thứ cho sự xúc phạm nhưng không bao giờ quên sự coi thường.\",\"T\":\"P.Gordon\"},{\"D\":\"Phụ nữ bao giờ cũng yêu vì tài trước khi yêu vẻ bề ngoài.\",\"T\":\"Banzac\"},{\"D\":\"Im lặng đem đến cho người phụ nữ sự kính nể.\",\"T\":\"Sophocle\"},{\"D\":\"Tình yêu thành thật làm cho người phụ nữ trở nên kín đáo và ít bộc lộ.\",\"T\":\"Bartheb \"},{\"D\":\"Trước con mắt của người yêu, không có người phụ nữ nào xấu cả.\",\"T\":\"Ronsard \"},{\"D\":\"Trước phái đẹp và âm nhạc, thời gian sẽ trở thành vô nghĩa.\",\"T\":\"A.Xmit\"},{\"D\":\"Dũng cảm: Đó là trách nhiệm được ý thức đến cùng.\",\"T\":\"Paplenko\"},{\"D\":\"Dễ dãi là phương châm của thể xác và là tro nguội của tâm hồn.\",\"T\":\"Ngạn ngữ Đức\"},{\"D\":\"Nếu sự khiêm nhường của bạn khiến mọi người để ý thì hẳn có chút đó chẳng bình thường.\",\"T\":\"M. Ghenin.\"},{\"D\":\"Mỗi người đều có 3 tính cách:tính cách phô ra, tính cách họ có và tính cách họ nghĩ rằng họ có.\",\"T\":\"Vauvenargues\"},{\"D\":\"Khiêm tốn bao nhiêu cũng chưa đủ, tự kiêu một chút cũng là nhiều.\",\"T\":\"Karl Marx\"},{\"D\":\"Sự yêu chuộng cái đẹp là phần cốt yếu của một nhân tính lành mạnh.\",\"T\":\"J. Ruskin\"},{\"D\":\"Cái gì hấp dẫn và đẹp đẽ chẳng phải luôn luôn là tốt, nhưng cái gì tốt thì luôn luôn đẹp.\",\"T\":\"Ninonde Lenenles\"},{\"D\":\"Tôi biết có một điều tốt đẹp hơn cả sự ngay thẳng: ấy là sự khoan dung.\",\"T\":\"V.Hugo\"},{\"D\":\"Thói quen là một bản tính thứ hai.\",\"T\":\"Cicero\"},{\"D\":\"Danh dự như que diêm, cháy một lần là hết.\",\"T\":\"M.Pagnol\"},{\"D\":\"Sắc đẹp là hoa còn đạo đức là quả của cuộc đời.\",\"T\":\"Ngạn ngữ Mỹ\"},{\"D\":\"Bản chất giản dị là kết quả tự nhiên của tư tưởng sâu sắc.\",\"T\":\"Hazlitt\"},{\"D\":\"Sự cao cả của con người nằm trong sức mạnh tư tưởng.\",\"T\":\"Tục ngữ Anh\"},{\"D\":\"Những tâm hồn thanh nhã không bao giờ sống chung được với những kẻ thô tục tầm thường.\",\"T\":\"An Bel Bonnard\"},{\"D\":\"Tri thức làm người ta khiêm tốn, ngu si làm người ta kiêu ngạo.\",\"T\":\"Ngạn ngữ Anh\"},{\"D\":\"Khoảng cách giữa đạo đức và thói xấu hẹp đến nỗi chỉ vừa đủ cho hoàn cảnh chêm vào.\",\"T\":\"J.M.Braodo\"},{\"D\":\"Can đảm là đức hạnh số một của con người vì nó đảm bảo cho tất cả những hạnh phúc khác.\",\"T\":\"Churchill\"},{\"D\":\"Mình thế nào mà không dám tỏ ra như thế là mình khinh mình.\",\"T\":\"Mat-xi-lông\"},{\"D\":\"Nếu trái tim bạn là một đóa hồng, miệng bạn sẽ thốt ra những lời ngát hương.\",\"T\":\"Ngạn ngữ Nga\"},{\"D\":\"Thiên tài và đức hạnh giống như viên kim cương: đẹp nhất là lồng trong chiếc khung giản dị.\",\"T\":\"X. Batle\"},{\"D\":\"Sức mạnh lớn nhất thường chỉ đơn giản là sự kiên nhẫn.\",\"T\":\"Giôxep Côtman\"},{\"D\":\"Tiêu chuẩn đánh giá con người là khát vọng vươn tới sự hoàn chỉnh.\",\"T\":\"W. Gớt\"},{\"D\":\"Khi thì mọi sự vô phương cứu chữa thì chính là lúc lòng kiên nhẫn cần được dùng đến.\",\"T\":\"G. Huttơn\"},{\"D\":\"Tính cách của con người được bộc lộ trung thực nhất qua những sự đối xử tình cờ nhất.\",\"T\":\"I.Rađep\"},{\"D\":\"Những người vĩ đại thật sự bao giờ cũng giản dị: cách cư xử của họ tự nhiên và thoải mái.\",\"T\":\"F.Clinghe\"},{\"D\":\"Giản dị chẳng những là điều tốt đẹp nhất mà còn là điều cao thượng nhất.\",\"T\":\"T.Phôntakê\"},{\"D\":\"Chân thành là nguồn sinh ra mọi thiên tài.\",\"T\":\"C.Becnê\"},{\"D\":\"Phần thưởng đáng giá nhất là phần thưởng do danh dự đem lại, không có gì hơn.\",\"T\":\"A.France\"},{\"D\":\"Trí tuệ của con người trưởng thành trong tĩnh lặng, còn tính cách trưởng thành trong bão táp.\",\"T\":\"W.Gơt\"},{\"D\":\"Người cao thượng là người không bao giờ làm một điều gì để hạ thấp người khác.\",\"T\":\"A.Ca-sơn\"},{\"D\":\"Trên đường đời, hành lí của con người cần mang theo là lòng kiên nhẫn và tính chịu đựng.\",\"T\":\"Maiacopxki\"},{\"D\":\"Chỉ có những khát vọng và những khát vọng lớn lao mới có thể nâng tâm hồn lên tầm vĩ đại.\",\"T\":\"Điđơrô\"},{\"D\":\"Một cách chắc chắn nhất để nâng cao phẩm cách con người là đặt nó ra khỏi sự nhu cầu.\",\"T\":\"A.Blanki\"},{\"D\":\"Trên đời này, không có cái thái quá nào đẹp hơn cái thái quá về sự tri ân.\",\"T\":\"La Bruyere\"},{\"D\":\"Nếu danh dự bắt buộc phải lên tiếng mà lại im lặng thì là một sự hèn nhát.\",\"T\":\"La Coocđơ\"},{\"D\":\"Căn bệnh nặng nhất của tâm hồn là sự lãnh đạm.\",\"T\":\"D.Tôkenvin\"},{\"D\":\"Nhân từ ngọt ngào là dấu hiệu của tính cao thượng.\",\"T\":\"Tago\"},{\"D\":\"Sự bình dị là sự nối giữa nhân ái và sắc đẹp.\",\"T\":\"Ngạn ngữ Hy Lạp\"},{\"D\":\"Không có sự vĩ đại nào lại không có sự giản dị, lòng tốt và sự thật.\",\"T\":\"L.Tonxtôi\"},{\"D\":\"Nếu trừng phạt đàn bà, tôi sẽ nhốt cô ta vào một cái phòng không có gương.\",\"T\":\"M.Asa\"},{\"D\":\"Không yêu một người đàn bà đẹp như vậy là một lỗi lầm, còn yêu cô ta – một sự trừng phạt.\",\"T\":\"V.Đêviat\"},{\"D\":\"Đàn bà yêu đàn ông ít nối bởi họ cứ nghĩ rằng:người đàn ông ấy đang lắng nghe họ.\",\"T\":\"X.Gitri\"},{\"D\":\"Người đang có ý định lấy vợ là người đang đi trên con đường dẫn tới sự hối hận.\",\"T\":\"Mêlangiơ\"},{\"D\":\"Không người đàn bà nào có thể nói “Tạm biệt” ít hơn 30 từ.\",\"T\":\"Bisou\"},{\"D\":\"Tất cả đàn bà đều hỏi chiếc gương của mình nhưng ít người chịu nghe chúng.\",\"T\":\"O.Phise\"},{\"D\":\"Tính cẩn thận là mẹ đẻ của sự an toàn nhưng lại là con đẻ của nỗi sợ hãi.\",\"T\":\"A.Xenblec\"},{\"D\":\"Họ giải quyết vấn đề này thật đơn giản: công nhận nó là vấn đề không thể giải quyết nổi.\",\"T\":\"V.Batôsêvich\"},{\"D\":\"Khi nào tình yêu còn mù quáng, khi ấy vẫn chưa có lý do nào để ly dị.\",\"T\":\"A.Anđriepxki\"},{\"D\":\"Sự thật lịch sử được làm nên bởi sự im lặng của những người đã chết.\",\"T\":\"F.Rây\"},{\"D\":\"Không nói lên được điều gì, đặc biệt là khi đang nói, đã là một nửa của nghệ thuật ngoại giao.\",\"T\":\"U.Điurarit\"},{\"D\":\"Hỡi loài người, hãy bảo vệ cây cối – tổ tiên của chúng ta đã từng sống ở trên đó.\",\"T\":\"M.Genin\"},{\"D\":\"Thanh niên họ tin rằng: tiền là tất cả và khi già đi, họ mới chắc chắn vào điều đó.\",\"T\":\"O. Uaind\"},{\"D\":\"Trả thù giống như bạn cắn một con chó sau khi bị nó cắn.\",\"T\":\"O.Omeli\"},{\"D\":\"Trẻ con bắt đầu hư khi chúng bắt đầu hiểu người lớn.\",\"T\":\"G.Mankin\"},{\"D\":\"Không ai làm nên nghệ thuật mà lại nhìn mọi điều đều giống như trong thực tế cả.\",\"T\":\"O.Uaind\"}]}";

function set_uiDate(){
    var query = window.location.search;	
    if(query == '')
        ui_currentDate = get_currentDate();	
    else
        ui_currentDate = get_dateFromQuery(query);
    ui_nextDate = get_nextDate();
    ui_prevDate = get_prevDate();
}
function get_dateFromQuery(query){			
    var arr = parseQuery(query);	
    var idx;
    var d; var m; var y;
    for (idx = 0; idx < arr.length; idx++) {
        if (arr[idx] == "mm") {				
            m = parseInt(arr[idx+1]) - 1;								
        } else if (arr[idx] == "yy") {
            y = parseInt(arr[idx+1]);
        } else if (arr[idx] =="dd") {
            d = parseInt(arr[idx+1]);
        } else if (arr[idx] =="direction") {
            direction = arr[idx+1];
        }
    }		
    var _date = new Date(y,m,d);		
    var inputDate = moment(_date);
    return inputDate;
}
function get_currentDate(){
    var currentDate = moment();    
    return currentDate;
}
function get_nextDate(){	
    var _date = new Date(ui_currentDate.year(), ui_currentDate.month(), ui_currentDate.date());
    _date.setDate(_date.getDate() + 1);
    var nextDate = moment(_date);
    return nextDate;
}
function get_prevDate(){		
    var _date = new Date(ui_currentDate.year(), ui_currentDate.month(), ui_currentDate.date());
    _date.setDate(_date.getDate() - 1);
    var prevDate = moment(_date);
    return prevDate;
}
function dateInRange(currentDate, upperBound, lowerBound){
	var IsYearSubtracted = false
	if(currentDate.getMonth() == 11 && currentDate.getDate() >= 22){
		currentDate.setFullYear(currentDate.getFullYear() - 1);
		IsYearSubtracted = true;
	}
	if(currentDate < upperBound || currentDate > lowerBound){
		if(IsYearSubtracted) currentDate.setFullYear(currentDate.getFullYear() + 1);
		return false;
	}
	if(IsYearSubtracted) currentDate.setFullYear(currentDate.getFullYear() + 1);
	return true;
}
function get_cungHoangDao(currentDate){
	var currentYear = currentDate.getFullYear();
	var _Aries = new Date(currentYear,2,21,0,0,0);
	var Aries_ = new Date(currentYear,3,20,0,0,0);
	var _Taurus = new Date(currentYear,3,21,0,0,0);
	var Taurus_ = new Date(currentYear,4,21,0,0,0);
	var _Gemini = new Date(currentYear,4,22,0,0,0);
	var Gemini_ = new Date(currentYear,5,21,0,0,0);
	var _Cancer = new Date(currentYear,5,22,0,0,0);
	var Cancer_ = new Date(currentYear,6,23,0,0,0);
	var _Leo = new Date(currentYear,6,24,0,0,0);
	var Leo_ = new Date(currentYear,7,23,0,0,0);
	var _Virgo = new Date(currentYear,7,24,0,0,0);
	var Virgo_ = new Date(currentYear,8,23,0,0,0);
	var _Libra = new Date(currentYear,8,24,0,0,0);
	var Libra_ = new Date(currentYear,9,23,0,0,0);
	var _Scorpio = new Date(currentYear,9,24,0,0,0);
	var Scorpio_ = new Date(currentYear,10,22,0,0,0);
	var _Sagittarius = new Date(currentYear,10,23,0,0,0);
	var Sagittarius_ = new Date(currentYear,11,21,0,0,0);
	var _Capricornus = new Date(currentYear-1,11,22,0,0,0);
	var Capricornus_ = new Date(currentYear,0,20,0,0,0);
	var _Aquarius = new Date(currentYear,0,21,0,0,0);
	var Aquarius_ = new Date(currentYear,1,19,0,0,0);
	var _Pisces = new Date(currentYear,1,20,0,0,0);
	var Pisces_ = new Date(currentYear,2,20,0,0,0);
	if(dateInRange(currentDate,_Capricornus,Capricornus_)) return 'capricorn|Ma Kết (22/12-20/1)';
	if(dateInRange(currentDate,_Aries,Aries_)) return 'aries|Dương Ngưu (21/3-20/4)';
	if(dateInRange(currentDate,_Taurus,Taurus_)) return 'taurus|Kim Ngưu (21/4-21/5)';
	if(dateInRange(currentDate,_Gemini,Gemini_)) return 'gemini|Song Sinh (22/5-21/6)';
	if(dateInRange(currentDate,_Cancer,Cancer_)) return 'cancer|Cự Giải (22/6-23/7)';
	if(dateInRange(currentDate,_Leo,Leo_)) return 'leo|Sư Tử (24/7-23/8)';
	if(dateInRange(currentDate,_Virgo,Virgo_)) return 'virgo|Xử Nữ (24/8-23/9)';
	if(dateInRange(currentDate,_Libra,Libra_)) return 'libra|Thiên Bình (24/9-23/10)';
	if(dateInRange(currentDate,_Scorpio,Scorpio_)) return 'scorpio|Bọ Cạp (24/10-22/11)';
	if(dateInRange(currentDate,_Sagittarius,Sagittarius_)) return 'sagittarius|Nhân Mã (23/11-21/12)';
	if(dateInRange(currentDate,_Capricornus,Capricornus_)) return 'capricorn|Ma Kết (22/12-20/1)';
	if(dateInRange(currentDate,_Aquarius,Aquarius_)) return 'aquarius|Bảo Bình (21/1-19/2)';
	if(dateInRange(currentDate,_Pisces,Pisces_)) return 'pisces|Song Ngư (20/2-20-3)';
}

function LunarDateObject(inputDate){		
    var currentLunarDate = getLunarDate(inputDate.date(),inputDate.month()+1,inputDate.year());
    this.CurrentMonthYear = function(){
        var month = inputDate.month() + 1;
        s = "Tháng " + month + " Năm " + inputDate.year();		
        return s;
    };
    this.CurrentDay = function(){
        return inputDate.date()
    };
    this.DayOfWeek = function(){
        return TUAN[(currentLunarDate.jd+1) % 7 ];
    };
    this.GioHoangDao = function(){
        return getGioHoangDao(currentLunarDate.jd);
    };
    this.CurrentLunarMonth = function(){
        return THANGAMLICH[(currentLunarDate.month - 1)];
    };
    this.CurrentLunarDate = function(){
        return currentLunarDate.day;
    };
    this.CurrentLunarYear = function(){		
        if (currentLunarDate.day == 0) {
            return "";
        }		        
        var cc = getCanChi(currentLunarDate);		    
        var s = "Năm " + cc[2];
        return s;
    }
    this.CanChiThang = function(){
        if (currentLunarDate.day == 0) {
            return "";
        }	    
        var cc = getCanChi(currentLunarDate);    
        var s = "Tháng " + cc[1];
        return s;
    }
    this.CanChiGio = function(){
        var s = "Giờ "+getCanHour0(currentLunarDate.jd)+" "+CHI[0];
        return s;
    }
    this.CanChiNgay = function(){
        if (currentLunarDate.day == 0) {
            return "";
        }	    
        var cc = getCanChi(currentLunarDate);	    
        var s = "Ngày " + cc[0];
        return s;
    }
    this.TietKhi = function(){
        var s = "Tiết "+TIETKHI[getSunLongitude(currentLunarDate.jd+1, 7.0)];
        return s;
    }
	this.DanhNgon = function(){
		var danhngonArray = JSON.parse(DanhNgon_data);
        var rand = Math.floor((Math.random()*279)+0); //return random number in [0,279)
        var s = danhngonArray.Node[rand].D + ' <b>(' + danhngonArray.Node[rand].T + ')</b>';
        return s;
	}
	this.CungHoangDao = function(){
		var jsDate = new Date(inputDate.year(),inputDate.month(),inputDate.date(),0,0,0);
		var _cungHoangDao = get_cungHoangDao(jsDate);
		if(_cungHoangDao){
			var arr = _cungHoangDao.split('|');
			var site = arr[0];
			var cung = arr[1];		
			var s = "Cung: <a class='zodiacLink' href='cung/" + site + ".html'>" + cung + "</a>";		
			return s;	
		}
		else return 'error';
	}
}

function set_calendar(selector, inputDate){	
    lunar = new LunarDateObject(inputDate);	
    $(selector + ' .monthYear').html(lunar.CurrentMonthYear());
    $(selector + ' .date').html(lunar.CurrentDay());
    $(selector + ' .dayofWeek').html(lunar.DayOfWeek());
    $(selector + ' .danhngon').html(lunar.DanhNgon());
    $(selector + ' .cunghoangdao').html(lunar.CungHoangDao());
    $(selector + ' .giohoangdao').html(lunar.GioHoangDao());
    $(selector + ' .LunarMonth').html(lunar.CurrentLunarMonth());
    $(selector + ' .LunarDate').html(lunar.CurrentLunarDate());
    $(selector + ' .LunarYear').html(lunar.CurrentLunarYear());
    $(selector + ' .canchithang').html(lunar.CanChiThang());
    $(selector + ' .canchigio').html(lunar.CanChiGio());
    $(selector + ' .canchingay').html(lunar.CanChiNgay());
    $(selector + ' .tietkhi').html(lunar.TietKhi());
}

function goToNextDate(){
    var url = 'index.html?' + 'yy=' + ui_nextDate.year() + '&mm=' + (ui_nextDate.month() + 1) + '&dd=' + ui_nextDate.date() + '&direction=left';
    window.location.href = url;
}

function goToPrevDate(){
    var url = 'index.html?' + 'yy=' + ui_prevDate.year() + '&mm=' + (ui_prevDate.month() + 1) + '&dd=' + ui_prevDate.date() + '&direction=right';
    window.location.href = url;
}

function flip(){
    switch(direction){
        case 'left':
            set_calendar('.front', ui_prevDate);
            set_calendar('.back', ui_currentDate);
            $('.content').addClass('rightToLeft-flip');
            break;
        case 'right':
            set_calendar('.front', ui_nextDate);
            set_calendar('.back', ui_currentDate);
            $('.content').addClass('leftToRight-flip');
            break;
        default:
            $('.content').hide();
            set_calendar('.front', ui_currentDate);
            $('.content').fadeIn(200);
    }	
}

function flipLeft() {
    set_calendar('.front', ui_prevDate);
    set_calendar('.back', ui_currentDate);
    $('.content').addClass('rightToLeft-flip');
}

function flipRight (){
    set_calendar('.front', ui_nextDate);
    set_calendar('.back', ui_currentDate);
    $('.content').addClass('leftToRight-flip');
}