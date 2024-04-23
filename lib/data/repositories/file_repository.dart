
import '../../utils/images/app_images.dart';
import '../models/file_data_model.dart';

class FileRepository {
  List<FileDataModel> files = [
    FileDataModel(
      iconPath: AppImages.boy,
      fileName: "PythonBooks",
      fileUrl: "https://bilimlar.uz/wp-content/uploads/2021/02/k100001.pdf",
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMh34DPK8RyB1zIg3PGEJtIoH1X5vB1SoIfXYMB23lg&s',
        status: 'Fantastika',

    ),
    FileDataModel(
      iconPath: AppImages.boy,
      fileName: "Jahon tarixi",
      fileUrl: "https://drive.google.com/file/d/1VJD6WWNIWnynzamPLk_eVxKtIJ-6wojr/view",
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoTE2xDailaQvr_KfYaAynlFGeOOjyGNH_r0Dl8hGhZg&s',
        status: 'Tarix'

    ),
    FileDataModel(
      iconPath: AppImages.boy,
      fileName: "Informatika",
      fileUrl: "https://drive.google.com/file/d/1rMNo2e03C3PWb6EzMOKE-83PIxYu_GQ-/view",
      imageUrl: 'https://info-master.uz/wp-content/uploads/2022/09/7-informatika-2021-info-master.uz__2_1.jpg',
      status: 'IT'
    ),
    FileDataModel(
      iconPath: AppImages.boy,
      fileName: "Kuntugmish",
      fileUrl: "https://cdn.pixabay.com/video/2020/09/02/48873-457671829_large.mp4",
      imageUrl: '',
        status: 'Romantika'
    ),
    FileDataModel(
      iconPath: AppImages.boy,
      fileName: "Garry Potter",
      fileUrl: "https://cdn.pixabay.com/video/2020/09/02/48873-457671829_large.mp4",
      imageUrl: '',
        status: 'tarix'

    ),
    FileDataModel(
      iconPath: AppImages.boy,
      fileName: "Kimdur",
      fileUrl: "https://cdn.pixabay.com/video/2020/09/02/48873-457671829_large.mp4",
      imageUrl: '',
        status: 'tarix'

    ),
  ];
}
