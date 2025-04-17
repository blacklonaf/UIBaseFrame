import 'models/place.dart';

final dummyPlaces = [
  Place(
    name: '포레오',
    category: '인융대 / 음식점',
    address: '서울 노원구 광운로 46',
    imageUrl: null,
    benefitTitle: '2인당 캔 음료 1개',
    benefitSub: '18시 이후 방문시,\n1인당 야채춘권 1개로 변경 가능',
    restriction: '인융대 학생 인증 필요',
    restrictionSub: '중앙도서관 QR코드를 통해 인증',
    isOpen: true,
    expireDate: '2025/04/30 까지',
    latitude: 37.623569,
    longitude: 123.061899,
  ),
  Place(
    name: '삼겹하우스',
    category: '전정대 / 주점',
    address: '서울 성북구 화랑로 23',
    imageUrl: null,
    benefitTitle: '맥주 무제한 1시간',
    benefitSub: '18시 이전 방문 시에만 적용',
    restriction: '전정대 학생 인증 필요',
    restrictionSub: '학생증 또는 모바일 학생 인증 필요',
    isOpen: true,
    expireDate: '2025/05/15 까지',
    latitude: 37.623569,
    longitude: 127.061899,
  ),
];
