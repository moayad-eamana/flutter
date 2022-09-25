import 'package:eamanaapp/model/violation/building_license_model.dart';
import 'package:eamanaapp/model/violation/bunud_model.dart';
import 'package:eamanaapp/model/violation/comment.dart';
import 'package:eamanaapp/model/violation/commercial_Record_model.dart';
import 'package:eamanaapp/model/violation/hafreat_model.dart';
import 'package:eamanaapp/model/violation/shop_licenses_model.dart';
import 'package:eamanaapp/model/violation/violationAdds_model.dart';
import 'package:eamanaapp/model/violation/violation_skn_mohdel.dart';

import 'IndividualUserInfoModel.dart';

class VaiolationModel {
  Comment comment = Comment();
  IndividualUserInfoModel individualUserInfoModel = IndividualUserInfoModel();
  Commercial_Record_model commercial_Record_model = Commercial_Record_model();
  Building_license_model building_license_model = Building_license_model();
  Hafreat_model hafreat_model = Hafreat_model();
  Shop_licenses_model shop_licenses_model = Shop_licenses_model();
  Violation_skn_mohdel violation_skn_mohdel = Violation_skn_mohdel();
  ViolationAdds_model violationAdds_model = ViolationAdds_model();
  Bunud_model bunud_model = Bunud_model();
}
