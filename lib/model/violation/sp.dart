if (ddlUserType.SelectedValue == "1" || ddlViolType.SelectedValue == "1")
                        {// افراد
                            newItem["IdentityOrCommericalNumber"] = txtIdentityOrCommercialNumber.Text;
                            newItem["IndividualNameOrCompanyName"] = txtIndividualCompanyName.Text;
                            newItem["MobileNumber"] = txtMobileNumber.Text;
                            if (ddlViolType.SelectedValue == "1")
                            {
                          //سجل تجاري
                                newItem["LicenseNumberForCommercial"] = txtLicenseNumberForCommercial.Text == null ? "" : txtLicenseNumberForCommercial.Text.Trim();
                                newItem["ViolationSelected"] = ddlViolType.SelectedItem.Text;//new edit
                            }
                        }
                        else if (ddlViolType.SelectedValue == "2")
                        {//رخص المحلات
                            newItem["ShopLicense"] = txtIdentityOrCommercialNumber.Text;
                            newItem["IdentityOrCommericalNumber"] = txtIdentityOrCommercialNumberShopLic.Text;
                            newItem["IndividualNameOrCompanyName"] = txtCompanyNameShopLic.Text;
                            newItem["MobileNumber"] = txtMobileNumberShopLic.Text;
                            newItem["StoreDistance"] = txtdistanceShopLic.Text;
                            newItem["LicenseExpirDate"] = txtLicenseExpirationDateShopLic.Text;
                            newItem["Activity"] = txtActivityShopLic.Text;
                            newItem["ViolationSelected"] = ddlViolType.SelectedItem.Text;//new edit
                        }
                        else if (ddlViolType.SelectedValue == "3")
                        {//رخص للوحات الاعلانية
                            newItem["advboardlicense"] = txtadvboard.Text;
                            newItem["IdentityOrCommericalNumber"] = txtIdentityOrCommercialNumberAdvBoard.Text;
                            newItem["IndividualNameOrCompanyName"] = txtAdvBoardName.Text;
                            newItem["advboardDistance"] = txtdistanceAdvBoard.Text;
                            newItem["LicenseExpirDate"] = txtLicenseExpirationDateAdvBoard.Text;
                            newItem["ViolationSelected"] = ddlViolType.SelectedItem.Text;//new edit
                            newItem["MobileNumber"] = txtMobileNumberAdvBoard.Text;//new edit
                        }
                        else if (ddlViolType.SelectedValue == "4")  //if digging lic
                        {//الحفريات
                            newItem["DiggingLicense"] = txtIdentityOrCommercialNumber.Text;
                            newItem["IdentityOrCommericalNumber"] = txtCRNumberDiggLic.Text;
                            newItem["IndividualNameOrCompanyName"] = txtCompanyNameDigLic.Text;
                            newItem["MobileNumber"] = txtMobNumDigLic.Text;
                            newItem["DiggingArea"] = txtAreaDigLic.Text;
                            newItem["BeneficiaryName"] = txtbeneficiaryDigLic.Text;
                            newItem["LocOrPurposeDesc"] = txtLocDescDigLic.Text;
                            newItem["ViolationSelected"] = ddlViolType.SelectedItem.Text;//new edit
                        }
                        else if (ddlViolType.SelectedValue == "5")  //if building lic
                        {//رخص بناء
                            newItem["BuildingLicense"] = txtIdentityOrCommercialNumber.Text;
                            newItem["IdentityOrCommericalNumber"] = txtCRNumberBldgLic.Text;
                            newItem["IndividualNameOrCompanyName"] = txtOwnerNameBldgLic.Text;
                            newItem["MobileNumber"] = txtMobNumBldgLic.Text;
                            newItem["AreaBuildingLic"] = txtAreaBldgLic.Text;
                            newItem["LocOrPurposeDesc"] = txtProposedDescBldgLic.Text;
                            newItem["CompanyEngName"] = txtEngNameBldgLic.Text;
                            newItem["ViolationSelected"] = ddlViolType.SelectedItem.Text;//new edit
                        }
                        else if (ddlViolType.SelectedValue == "6")  // domitory Lic
                        {//سكن جماعي
                            newItem["DormitoryLicense"] = txtIdentityOrCommercialNumber.Text;
                            newItem["IdentityOrCommericalNumber"] = txtIdentityOrCommercialNumberDormitoryLic.Text;
                            newItem["IndividualNameOrCompanyName"] = txtDormitoryName.Text;
                            newItem["MobileNumber"] = txtMobileNumberDormitoryLic.Text;
                            newItem["DormitoryArea"] = txtdistanceDormitoryLic.Text;
                            newItem["DormitoryLicenseExpireDate"] = txtLicenseExpirationDateDormitoryLic.Text;
                            newItem["DormitoryType"] = txtDormitoryType.Text;
                            newItem["ViolationSelected"] = ddlViolType.SelectedItem.Text;//new edit
                        }
                        newItem["UserType"] = ddlUserType.SelectedItem.Text;
                        //newItem["DistrictCode"] = ddlDistrictName.SelectedValue;
                        newItem["DistrictName"] = txtDistrictName.Text;
                        newItem["StreetCode"] = string.Empty;//ddlStreetName.SelectedValue;
                        newItem["StreetName"] = txtStreetName.Text;//ddlStreetName.SelectedItem.Text;
                        newItem["BerifDescription"] = txtBerifDesc.Text;
                        newItem["AdditionalDescription"] = txtAdditionalDesc.Text;
                        //newItem["LicenceNumber"] = txtLicenceNumber.Text;
                        //newItem["LicenceDate"] = txtLicenceDate.Text;
                        newItem["Status"] = "Pending";
                        newItem["SADADStatus"] = "False";
                        newItem["SendOrSaveStatus"] = SendOrSaveStatus;//this reques is for Save Only
                        newItem["DateOfBirth"] = TextDateOfBirth.Text;
                        if (HfCRexpired.Value == "true")
                        {
                            newItem["CRExpired"] = "true";
                        }
                        SpEnterprise.SPManager.HierarchyManagers utilities = new HierarchyManagers();
                        SPGroupDetails gdetails = utilities.GetReportingToGroup(SPContext.Current.Web.CurrentUser.Name, (Int32)SpEnterprise.SPManager.Constants.Module.Violations);
                        if (gdetails != null)
                        {
                            newItem["TransferedDepartment"] = gdetails.GroupName;
                            newItem["CreatedDepartment"] = gdetails.GroupName;
                        }
                        decimal TotalValue = Convert.ToDecimal(gvRulesInAddViolations.FooterRow.Cells[7].Text);
                        //decimal TotalValue = Convert.ToDecimal(gvRulesInAddViolations.FooterRow.Cells[4].Text);
                        newItem["TotalValue"] = TotalValue;
                        newItem.Update();
                        itemId = newItem.ID.ToString();









