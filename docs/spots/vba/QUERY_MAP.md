# SPOTS — Query Map

Version: 0.1.0  ·  Last Updated: 2026-06-10  ·  Source: `docs/spots/vba/queries/` (347 files)

Classification:

- **keep** — straight Postgres view candidate (lookups, simple selects).

**Totals:** keep 166 · rebuild 156 · deprecate 25

- **rebuild** — rewrite as Postgres view / RPC against the new tenanted schema.
- **deprecate** — `_OLD`/`_BAK`/`xxxx`, studio-specific (`JKB`, `CONTINENTAL`), or superseded.


## Audit  (8)

| Query | Disposition | First FROM |
|---|---|---|
| `000AuditReport_OLD` | deprecate | `` |
| `000AuditReport_OLD2` | deprecate | `` |
| `itrLatestAction` | keep | `Actions` |
| `itrLatestAction_Select` | keep | `Actions` |
| `qAction5` | keep | `Actions` |
| `qAction6` | keep | `Actions` |
| `q_ActionList` | keep | `Actions` |
| `000AuditReport` | rebuild | `` |

## Cleanup  (1)

| Query | Disposition | First FROM |
|---|---|---|
| `000delAppts` | rebuild | `000delCust` |

## Customer  (30)

| Query | Disposition | First FROM |
|---|---|---|
| `eclSittingFinancialCustList_JKB` | deprecate | `CustomerListData` |
| `CustomersWithoutOrdersByPhotographer` | keep | `` |
| `eclSittingFinancialCustList` | keep | `CustomerListData` |
| `eclSittingFinancialCustList_DateRange` | keep | `CustomerListData` |
| `qCustList1` | keep | `Customers` |
| `qCustList1A` | keep | `` |
| `qCustList2` | keep | `qCustList1` |
| `qCustList2A` | keep | `qCustList1A` |
| `qCustomerOrder` | keep | `Photographers` |
| `qCustomerPhotographer` | keep | `Photographers` |
| `qCustomerPoseOrders` | keep | `PoseOrders` |
| `qList_Ord_CustList` | keep | `` |
| `qList_Photod_CustList` | keep | `` |
| `qMLabel_NoAppts_CustList` | keep | `qMLabel_NoAppts` |
| `qMLabel_Not_Ord2_CustList` | keep | `qMLabel_Not_Ord2` |
| `qMLabel_Not_Photod2_CustList` | keep | `qMLabel_Not_Photod2` |
| `qMLabel_Ord_CustList` | keep | `qMLabel_Ord` |
| `qMLabel_Photod_CustList` | keep | `qMLabel_Photod` |
| `qMLabel_Photod_Datetime_CustList` | keep | `qMLabel_Photod_Datetime` |
| `qMLabel_PrfOut2_CustList` | keep | `qMLabel_PrfOut2` |
| `qu_Cust Without Sess` | keep | `Customers` |
| `qu_Cust without SchID` | keep | `Customers` |
| `tmpMLabelsDateTime_CustList` | keep | `tmpMLabelsDateTime` |
| `tmpMLabels_CustList` | keep | `tmpMLabels` |
| `000delCust` | rebuild | `Customers` |
| `000delCustComposite` | rebuild | `000delCust` |
| `000delCustCompositeBorders` | rebuild | `000delCust` |
| `000delCustCompositePages` | rebuild | `000delCust` |
| `000delCustCompositeUtility` | rebuild | `000delCust` |
| `000delCustomer` | rebuild | `Customers` |

## Image  (8)

| Query | Disposition | First FROM |
|---|---|---|
| `qYearbookShootList_YBPose` | keep | `PoseOrders` |
| `000delPoseOrders` | rebuild | `000delCust` |
| `000delPoseSettings` | rebuild | `000delCust` |
| `Pose Count By Photographer` | rebuild | `Orders` |
| `Pose Count By Photographer1` | rebuild | `Pose` |
| `Pose Count By Sales Person` | rebuild | `Users` |
| `Pose Count By Sales Person1` | rebuild | `Pose` |
| `qPhotographerOrder_TotalPoses` | rebuild | `` |

## Lookup  (21)

| Query | Disposition | First FROM |
|---|---|---|
| `qAllRetouch1` | keep | `` |
| `qAllRetouch2` | keep | `qAllRetouch1` |
| `qList_Ord` | keep | `` |
| `qList_Photod` | keep | `` |
| `qMLabel_NoAppts` | keep | `` |
| `qMLabel_Not_Ord1` | keep | `` |
| `qMLabel_Not_Ord2` | keep | `qMLabel_Not_Ord1` |
| `qMLabel_Not_Photd1` | keep | `Customers` |
| `qMLabel_Not_Photod2` | keep | `qMLabel_Not_Photd1` |
| `qMLabel_Ord` | keep | `` |
| `qMLabel_Photod` | keep | `` |
| `qMLabel_Photod_Datetime` | keep | `` |
| `qMLabel_PrfOut1` | keep | `Sessions` |
| `qMLabel_PrfOut2` | keep | `qMLabel_PrfOut1` |
| `qYearBookShootList1` | keep | `Actions` |
| `qYearBookShootList2` | keep | `qYearBookShootList2New` |
| `qYearBookShootList2New` | keep | `` |
| `qhotlist1` | keep | `Actions` |
| `qhotlist2` | keep | `` |
| `qhotlist3` | keep | `` |
| `qhotlist4` | keep | `qhotlist3` |

## Misc  (71)

| Query | Disposition | First FROM |
|---|---|---|
| `eclSittingFinancailDetail_JKB` | deprecate | `Sessions` |
| `eclSittingFinancialSum_JKB` | deprecate | `eclSittingFinancailDetail` |
| `qYrBook_Paid1_Old` | deprecate | `` |
| `qYrBook_Paid2_Old` | deprecate | `` |
| `QU_SESS` | keep | `9` |
| `Qu_schools` | keep | `Studios` |
| `Query1` | keep | `PoseOrders` |
| `Query10` | keep | `` |
| `Query11` | keep | `` |
| `Query12` | keep | `OrderDetails` |
| `Query13` | keep | `Appointments` |
| `Query2` | keep | `` |
| `Query3` | keep | `` |
| `Query4` | keep | `` |
| `Query5` | keep | `Appointments` |
| `Query6` | keep | `SessionReportByDate` |
| `Query7` | keep | `` |
| `Query8` | keep | `` |
| `Query9` | keep | `` |
| `eclSittingFinancialDetail` | keep | `Sessions` |
| `eclSittingFinancialDetail_DateRange` | keep | `DepositPayments` |
| `eclSittingFinancialSum` | keep | `eclSittingFinancialDetail` |
| `eclSittingFinancialSum_DateRange` | keep | `eclSittingFinancialDetail_DateRange` |
| `itrApptsAdded` | keep | `` |
| `qDClose1` | keep | `Sessions` |
| `qDClose2` | keep | `Orders` |
| `qDClose3` | keep | `Sessions` |
| `qDClose4` | keep | `Shipping` |
| `qMissAppt1` | keep | `` |
| `qMissAppt2` | keep | `qMissAppt1` |
| `qRutgersUpdateSchoolId` | keep | `` |
| `qSessBalDue1` | keep | `Customers` |
| `qSessBalDue1_XXX` | keep | `Customers` |
| `qSessBalDue2` | keep | `qSessBalDue1` |
| `qSessBalDue2_XXX` | keep | `qSessBalDue1` |
| `qYBO1` | keep | `Customers` |
| `qYBO1Test` | keep | `Customers` |
| `qYBO2` | keep | `Sessions` |
| `qYBO2Test` | keep | `Sessions` |
| `qYBO3` | keep | `` |
| `qYBO3Test` | keep | `` |
| `qYBOMiss1` | keep | `Customers` |
| `qYBOMiss2` | keep | `qYBOMiss1` |
| `qYrBook_Not_Paid1` | keep | `Sessions` |
| `qYrBook_Not_Paid2` | keep | `qYrBook_Not_Paid1` |
| `qYrBook_Paid1` | keep | `` |
| `qYrBook_Paid2` | keep | `` |
| `qphotog1` | keep | `Sessions` |
| `qphotog2` | keep | `Sessions` |
| `qphotog3` | keep | `Sessions` |
| `qphotog4` | keep | `qphotog3` |
| `qphotog5` | keep | `qphotog3` |
| `qphotog6` | keep | `qphotog5` |
| `qphotog7` | keep | `qphotog3` |
| `qphotog8` | keep | `` |
| `qpkg_by_datetime` | keep | `Sessions` |
| `qpkg_by_school10_new` | keep | `` |
| `qpkg_by_school1_new` | keep | `Customers` |
| `qpkg_by_school2_new` | keep | `Sessions` |
| `qpkg_by_school3_new` | keep | `qpkg_by_school2_new` |
| `qpkg_by_school4_new` | keep | `Orders` |
| `qpkg_by_school5_new` | keep | `qpkg_by_school4_new` |
| `qpkg_by_school6_new` | keep | `qpkg_by_school4_new` |
| `qpkg_by_school7B_new` | keep | `` |
| `qpkg_by_school7_new` | keep | `qpkg_by_school4_new` |
| `qpkg_by_school8_new` | keep | `qpkg_by_school4_new` |
| `qpkg_by_school9_new` | keep | `qpkg_by_school8_new` |
| `qpkg_by_school_studio10_new` | keep | `` |
| `qpkg_by_school_studio11_new` | keep | `qpkg_by_school_studio10_new` |
| `qryRutagers_Append` | keep | `Rutgers` |
| `qu_noPhoto by school` | keep | `` |

## Order  (73)

| Query | Disposition | First FROM |
|---|---|---|
| `AccountsReceivable_OrderPaymentsJKB` | deprecate | `Orders` |
| `qSalespersonItemSummary1Total_Old` | deprecate | `qOrderReport2` |
| `qSalespersonItemSummary1_Old` | deprecate | `qOrderReport2` |
| `000PPDepositsOrders` | keep | `` |
| `000PPOrderDeposits` | keep | `` |
| `000PPOrderInfo` | keep | `` |
| `000PPOrderPayments` | keep | `` |
| `Orders Not Sent To Studio1` | keep | `Orders` |
| `Orders Not Sent To Studio2` | keep | `Orders` |
| `Orders Not Sent To Studio3` | keep | `Orders` |
| `PhotodButNoOrder` | keep | `Sessions` |
| `qOrderShipping` | keep | `Shipping` |
| `qOrderTax` | keep | `qOrderTaxDetail` |
| `qOrderTaxDetail` | keep | `` |
| `qPhotographerOrder0` | keep | `qSessionReport1` |
| `qPhotographerOrder1` | keep | `` |
| `qPhotographerOrder2` | keep | `qOrderReport2` |
| `qPhotographerOrder3` | keep | `` |
| `qSchoolOrder1` | keep | `` |
| `qSchoolOrder1Old` | keep | `qSessionReport2` |
| `qSchoolOrder2` | keep | `qOrderReport2` |
| `qSchoolOrder3` | keep | `qSchoolOrder1` |
| `qStudioOrder1` | keep | `` |
| `qStudioOrder2` | keep | `qOrderReport2` |
| `qStudioOrder3` | keep | `qStudioOrder1` |
| `q_OrderDetail` | keep | `Orders` |
| `q_OrderDetail_Back` | keep | `OrderItems` |
| `q_OrderInformation` | keep | `Orders` |
| `q_OrderOverview` | keep | `OrderDetails` |
| `q_PreviousOrderPayments` | keep | `` |
| `q_SumOrderPayments` | keep | `OrderPayments` |
| `qpkg_by_school4_new_orderitems` | keep | `` |
| `qryTrackingItem` | keep | `` |
| `000AuditOrders` | rebuild | `Customers` |
| `000AuditOrdersAmount` | rebuild | `` |
| `000AuditOrdersDetails` | rebuild | `OrderDetails` |
| `000AuditOrdersPayments` | rebuild | `Customers` |
| `000AuditOrdersTotalPayments` | rebuild | `Customers` |
| `000delOrder` | rebuild | `000delCust` |
| `000delOrderActions` | rebuild | `000delCust` |
| `000delOrderDetail` | rebuild | `000delCust` |
| `000delOrderPayment` | rebuild | `000delCust` |
| `000delOrderShipping` | rebuild | `` |
| `OrderDetailReport` | rebuild | `` |
| `OrderDetailReport1` | rebuild | `OrderDetailReport` |
| `OrderDetailReport1A` | rebuild | `OrderPayments` |
| `OrderDetailReport2` | rebuild | `OrderDetailReport1A` |
| `OrderReportByDate` | rebuild | `` |
| `TotalOrders` | rebuild | `Orders` |
| `itrPendingItemReport` | rebuild | `` |
| `qComissionReportOrderTotal` | rebuild | `OrderItems` |
| `qCommissionReport_OrdersTaken` | rebuild | `Orders` |
| `qCommissionReport_OrdersTaken_Total` | rebuild | `Orders` |
| `qOrderDateTotalDeposits` | rebuild | `DepositPayments` |
| `qOrderDateTotalPayments` | rebuild | `OrderPayments` |
| `qOrderReport1` | rebuild | `` |
| `qOrderReport2` | rebuild | `qOrderReport1` |
| `qOrderTotal` | rebuild | `OrderDetails` |
| `qOrderTotalDeposits` | rebuild | `DepositPayments` |
| `qOrderTotalPayments` | rebuild | `OrderPayments` |
| `qSalespersonItemSummary1` | rebuild | `qOrderReport2` |
| `qSalespersonItemSummary1Total` | rebuild | `qOrderReport2` |
| `qSalespersonItemSummary2` | rebuild | `qOrderReport2` |
| `qSalespersonItemSummary2Total` | rebuild | `qOrderReport2` |
| `qSalespersonItemSummary3` | rebuild | `` |
| `qSalespersonItemSummary3ICount` | rebuild | `` |
| `qSalespersonItemSummary3Total` | rebuild | `qSalespersonItemSummary1Total` |
| `qSalespersonItemSummary4` | rebuild | `qSalespersonItemSummary4A` |
| `qSalespersonItemSummary4A` | rebuild | `qSalespersonItemSummary3` |
| `qSalespersonOrder1` | rebuild | `qOrderReport2` |
| `qSalespersonOrder2` | rebuild | `qOrderReport2` |
| `qSalespersonOrder3` | rebuild | `` |
| `q_OrderStatusOverview` | rebuild | `` |

## Payment  (28)

| Query | Disposition | First FROM |
|---|---|---|
| `AccountReceivable1JKB` | deprecate | `OrderDetails` |
| `AccountReceivable1_CONTINENTAL` | deprecate | `` |
| `AccountReceivable2JKB` | deprecate | `OrderPayments` |
| `AccountReceivable3JKB` | deprecate | `` |
| `AccountReceivable3_OldJKB` | deprecate | `AccountReceivable1` |
| `AccountReceivable4JKB` | deprecate | `AccountReceivable3` |
| `AccountReceivable5JKB` | deprecate | `AccountReceivable4` |
| `AccountReceivable5_OldJKB` | deprecate | `AccountReceivable4` |
| `AccountsReceivable1JKB2` | deprecate | `` |
| `AccountsReceivable_DepositsJKB` | deprecate | `DepositPayments` |
| `PaymentsReportByDate_Old` | deprecate | `` |
| `000PPDepositsCR` | keep | `` |
| `UnusedDeposits` | keep | `DepositPayments` |
| `rtiPaymentHistory` | keep | `` |
| `000delDeposit` | rebuild | `000delCust` |
| `AccountReceivable Percent` | rebuild | `AccountReceivable` |
| `AccountReceivable Percent1` | rebuild | `AccountReceivable3` |
| `AccountReceivable-1` | rebuild | `ActionItems` |
| `AccountReceivable0` | rebuild | `Orders` |
| `AccountReceivable1` | rebuild | `` |
| `AccountReceivable1_080512` | rebuild | `OrderDetails` |
| `AccountReceivable2` | rebuild | `OrderPayments` |
| `AccountReceivable2-1` | rebuild | `DepositPayments` |
| `AccountReceivable3` | rebuild | `` |
| `AccountsReceivable2` | rebuild | `OrderPayments` |
| `AccountsReceivable2-1` | rebuild | `DepositPayments` |
| `PaymentsReportByDate` | rebuild | `` |
| `PaymentsReportByDate1` | rebuild | `` |

## Report  (34)

| Query | Disposition | First FROM |
|---|---|---|
| `qComissionReport_Old` | deprecate | `OrderItems` |
| `qComissionReport_Old2` | deprecate | `OrderItems` |
| `Portrait Sales By Sales Person1` | rebuild | `` |
| `Portrait Sales By Sales Person1_LineTotal` | rebuild | `` |
| `Portrait Sales By Sales Person2` | rebuild | `OrderItems` |
| `Portrait Sales By Sales Person2_LineTotal` | rebuild | `OrderItems` |
| `Portrait Sales By School1` | rebuild | `` |
| `Portrait Sales By School2` | rebuild | `` |
| `QPkg_Sales_Employee_Co4` | rebuild | `qPkg_Sales_Employee_Co2` |
| `QPkg_Sales_Employee_Studio4` | rebuild | `qPkg_Sales_Employee_Studio2` |
| `TotalSeniors` | rebuild | `Customers` |
| `TotalSeniorsPhotod` | rebuild | `Sessions` |
| `itrReprintsSentReport` | rebuild | `` |
| `qComissionReport` | rebuild | `qComissionReport_Union` |
| `qComissionReportComissionTotal` | rebuild | `OrderItems` |
| `qComissionReportCount` | rebuild | `OrderItems` |
| `qComissionReportFull` | rebuild | `OrderItems` |
| `qComissionReport_Union` | rebuild | `` |
| `qCreditCardReport` | rebuild | `` |
| `qIDCardReport` | rebuild | `Customers` |
| `qPkg_Sales_Employee_Co1` | rebuild | `Orders` |
| `qPkg_Sales_Employee_Co2` | rebuild | `qPkg_Sales_Employee_Co1` |
| `qPkg_Sales_Employee_Co3` | rebuild | `qPkg_Sales_Employee_Co1` |
| `qPkg_Sales_Employee_Co5` | rebuild | `Users` |
| `qPkg_Sales_Employee_Co_Rpt` | rebuild | `` |
| `qPkg_Sales_Employee_Studio1` | rebuild | `Orders` |
| `qPkg_Sales_Employee_Studio2` | rebuild | `qPkg_Sales_Employee_Studio1` |
| `qPkg_Sales_Employee_Studio3` | rebuild | `qPkg_Sales_Employee_Studio1` |
| `qPkg_Sales_Employee_Studio5` | rebuild | `` |
| `qPkg_Sales_Employee_Studio_Rpt` | rebuild | `` |
| `qShelfReport1` | rebuild | `Orders` |
| `qShelfReport2` | rebuild | `Actions` |
| `qSittingReport` | rebuild | `` |
| `q_RetouchStatus` | rebuild | `Orders` |

## Session  (73)

| Query | Disposition | First FROM |
|---|---|---|
| `000SessionStatusXXXX` | deprecate | `SessionStatus` |
| `SessionReportByDate_OLD` | deprecate | `` |
| `000PPSessionDeposits` | keep | `` |
| `000PPSessionInfo` | keep | `` |
| `000PPSessionPayments` | keep | `` |
| `q_AppointmentSchedule` | keep | `Appointments` |
| `q_PreviousSessionPayments` | keep | `` |
| `q_SessionInformation` | keep | `Sessions` |
| `q_SessionOrderOverview` | keep | `SessionDetail` |
| `q_SessionOrderOverview_Back` | keep | `SessionDetail` |
| `q_SessionOverview` | keep | `` |
| `q_SessionOverviewOld` | keep | `` |
| `q_SumSessionPayments` | keep | `SessionPayments` |
| `q_TempSession` | keep | `` |
| `qhotlist_session1` | keep | `SessionStatus` |
| `qhotlist_session2` | keep | `qhotlist_session1` |
| `qhotlist_session3` | keep | `` |
| `qhotlist_session4` | keep | `qhotlist_session3` |
| `000AuditSessionDeposit` | rebuild | `DepositPayments` |
| `000AuditSessionSelect` | rebuild | `` |
| `000AuditSessionSelectByDate` | rebuild | `Customers` |
| `000AuditSessionSelectByID` | rebuild | `` |
| `000AuditSessionSelectByIDDate` | rebuild | `` |
| `000AuditSessionTotalSession` | rebuild | `` |
| `000AuditSessions` | rebuild | `Customers` |
| `000AuditSessionsDetail` | rebuild | `SessionDetail` |
| `000AuditSessionsOld` | rebuild | `` |
| `000AuditSessionsPayments` | rebuild | `SessionPayments` |
| `000AuditSessionsTotalPayments` | rebuild | `SessionPayments` |
| `000SessionStatus` | rebuild | `SessionStatus` |
| `000delSession` | rebuild | `000delCust` |
| `000delSessionDetail` | rebuild | `000delCust` |
| `000delSessionPayment` | rebuild | `000delCust` |
| `000delSessionStatus` | rebuild | `000delCust` |
| `Session Sales By Sales Person1` | rebuild | `` |
| `Session Sales By Sales Person2` | rebuild | `Sessions` |
| `Session Sales By School1` | rebuild | `` |
| `Session Sales By School2` | rebuild | `` |
| `SessionReportByDate` | rebuild | `` |
| `SessionReportByDate_NEW` | rebuild | `` |
| `qSchoolOrder_SessionCount` | rebuild | `qSessionReport2` |
| `qSessionReport1` | rebuild | `` |
| `qSessionReport2` | rebuild | `qSessionReport1` |
| `qSession_Sales_Employee_Co1` | rebuild | `` |
| `qSession_Sales_Employee_Co1B` | rebuild | `` |
| `qSession_Sales_Employee_Co2` | rebuild | `` |
| `qSession_Sales_Employee_Co2B` | rebuild | `` |
| `qSession_Sales_Employee_Co3` | rebuild | `qSession_Sales_Employee_Co1` |
| `qSession_Sales_Employee_Co4` | rebuild | `` |
| `qSession_Sales_Employee_Co_Rpt` | rebuild | `qSession_Sales_Employee_Co1` |
| `qSession_Sales_Employee_Studio1` | rebuild | `` |
| `qSession_Sales_Employee_Studio1B` | rebuild | `` |
| `qSession_Sales_Employee_Studio2` | rebuild | `` |
| `qSession_Sales_Employee_Studio2B` | rebuild | `` |
| `qSession_Sales_Employee_Studio3` | rebuild | `qSession_Sales_Employee_Studio1` |
| `qSession_Sales_Employee_Studio4` | rebuild | `` |
| `qSession_Sales_Employee_Studio_Rpt` | rebuild | `qSession_Sales_Employee_Studio1` |
| `qSession_Sales_School_Co1` | rebuild | `` |
| `qSession_Sales_School_Co1B` | rebuild | `` |
| `qSession_Sales_School_Co2` | rebuild | `` |
| `qSession_Sales_School_Co2B` | rebuild | `` |
| `qSession_Sales_School_Co3` | rebuild | `qSession_Sales_School_Co1` |
| `qSession_Sales_School_Co4` | rebuild | `` |
| `qSession_Sales_School_Co_Rpt` | rebuild | `` |
| `qSession_Sales_School_Studio1` | rebuild | `` |
| `qSession_Sales_School_Studio1B` | rebuild | `` |
| `qSession_Sales_School_Studio2` | rebuild | `Sessions` |
| `qSession_Sales_School_Studio2B` | rebuild | `` |
| `qSession_Sales_School_Studio3` | rebuild | `qSession_Sales_School_Studio1` |
| `qSession_Sales_School_Studio4` | rebuild | `` |
| `qSession_Sales_School_Studio_Rpt` | rebuild | `` |
| `q_SessionStatusOverview` | rebuild | `` |
| `q_SessionStatusOverviewOld` | rebuild | `` |