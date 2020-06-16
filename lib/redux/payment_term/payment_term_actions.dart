import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewPaymentTermList extends AbstractNavigatorAction
    implements PersistUI, StopLoading {
  ViewPaymentTermList({
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final bool force;
}

class ViewPaymentTerm extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewPaymentTerm({
    @required NavigatorState navigator,
    @required this.paymentTermId,
    this.force = false,
  }) : super(navigator: navigator);

  final String paymentTermId;
  final bool force;
}

class EditPaymentTerm extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditPaymentTerm(
      {@required this.paymentTerm,
      @required NavigatorState navigator,
      this.completer,
      this.cancelCompleter,
      this.force = false})
      : super(navigator: navigator);

  final PaymentTermEntity paymentTerm;
  final Completer completer;
  final Completer cancelCompleter;
  final bool force;
}

class UpdatePaymentTerm implements PersistUI {
  UpdatePaymentTerm(this.paymentTerm);

  final PaymentTermEntity paymentTerm;
}

class LoadPaymentTerm {
  LoadPaymentTerm({this.completer, this.paymentTermId});

  final Completer completer;
  final String paymentTermId;
}

class LoadPaymentTermActivity {
  LoadPaymentTermActivity({this.completer, this.paymentTermId});

  final Completer completer;
  final String paymentTermId;
}

class LoadPaymentTerms {
  LoadPaymentTerms({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadPaymentTermRequest implements StartLoading {}

class LoadPaymentTermFailure implements StopLoading {
  LoadPaymentTermFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadPaymentTermFailure{error: $error}';
  }
}

class LoadPaymentTermSuccess implements StopLoading, PersistData {
  LoadPaymentTermSuccess(this.paymentTerm);

  final PaymentTermEntity paymentTerm;

  @override
  String toString() {
    return 'LoadPaymentTermSuccess{paymentTerm: $paymentTerm}';
  }
}

class LoadPaymentTermsRequest implements StartLoading {}

class LoadPaymentTermsFailure implements StopLoading {
  LoadPaymentTermsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadPaymentTermsFailure{error: $error}';
  }
}

class LoadPaymentTermsSuccess implements StopLoading, PersistData {
  LoadPaymentTermsSuccess(this.paymentTerms);

  final BuiltList<PaymentTermEntity> paymentTerms;

  @override
  String toString() {
    return 'LoadPaymentTermsSuccess{paymentTerms: $paymentTerms}';
  }
}

class SavePaymentTermRequest implements StartSaving {
  SavePaymentTermRequest({this.completer, this.paymentTerm});

  final Completer completer;
  final PaymentTermEntity paymentTerm;
}

class SavePaymentTermSuccess implements StopSaving, PersistData, PersistUI {
  SavePaymentTermSuccess(this.paymentTerm);

  final PaymentTermEntity paymentTerm;
}

class AddPaymentTermSuccess implements StopSaving, PersistData, PersistUI {
  AddPaymentTermSuccess(this.paymentTerm);

  final PaymentTermEntity paymentTerm;
}

class SavePaymentTermFailure implements StopSaving {
  SavePaymentTermFailure(this.error);

  final Object error;
}

class ArchivePaymentTermsRequest implements StartSaving {
  ArchivePaymentTermsRequest(this.completer, this.paymentTermIds);

  final Completer completer;
  final List<String> paymentTermIds;
}

class ArchivePaymentTermsSuccess implements StopSaving, PersistData {
  ArchivePaymentTermsSuccess(this.paymentTerms);

  final List<PaymentTermEntity> paymentTerms;
}

class ArchivePaymentTermsFailure implements StopSaving {
  ArchivePaymentTermsFailure(this.paymentTerms);

  final List<PaymentTermEntity> paymentTerms;
}

class DeletePaymentTermsRequest implements StartSaving {
  DeletePaymentTermsRequest(this.completer, this.paymentTermIds);

  final Completer completer;
  final List<String> paymentTermIds;
}

class DeletePaymentTermsSuccess implements StopSaving, PersistData {
  DeletePaymentTermsSuccess(this.paymentTerms);

  final List<PaymentTermEntity> paymentTerms;
}

class DeletePaymentTermsFailure implements StopSaving {
  DeletePaymentTermsFailure(this.paymentTerms);

  final List<PaymentTermEntity> paymentTerms;
}

class RestorePaymentTermsRequest implements StartSaving {
  RestorePaymentTermsRequest(this.completer, this.paymentTermIds);

  final Completer completer;
  final List<String> paymentTermIds;
}

class RestorePaymentTermsSuccess implements StopSaving, PersistData {
  RestorePaymentTermsSuccess(this.paymentTerms);

  final List<PaymentTermEntity> paymentTerms;
}

class RestorePaymentTermsFailure implements StopSaving {
  RestorePaymentTermsFailure(this.paymentTerms);

  final List<PaymentTermEntity> paymentTerms;
}

class FilterPaymentTerms implements PersistUI {
  FilterPaymentTerms(this.filter);

  final String filter;
}

class SortPaymentTerms implements PersistUI {
  SortPaymentTerms(this.field);

  final String field;
}

class FilterPaymentTermsByState implements PersistUI {
  FilterPaymentTermsByState(this.state);

  final EntityState state;
}

class FilterPaymentTermsByCustom1 implements PersistUI {
  FilterPaymentTermsByCustom1(this.value);

  final String value;
}

class FilterPaymentTermsByCustom2 implements PersistUI {
  FilterPaymentTermsByCustom2(this.value);

  final String value;
}

class FilterPaymentTermsByCustom3 implements PersistUI {
  FilterPaymentTermsByCustom3(this.value);

  final String value;
}

class FilterPaymentTermsByCustom4 implements PersistUI {
  FilterPaymentTermsByCustom4(this.value);

  final String value;
}

void handlePaymentTermAction(
    BuildContext context, List<BaseEntity> paymentTerms, EntityAction action) {
  if (paymentTerms.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  //final state = store.state;
  //final CompanyEntity company = state.company;
  final localization = AppLocalization.of(context);
  final paymentTerm = paymentTerms.first as PaymentTermEntity;
  final paymentTermIds =
      paymentTerms.map((paymentTerm) => paymentTerm.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: paymentTerm);
      break;
    case EntityAction.restore:
      store.dispatch(RestorePaymentTermsRequest(
          snackBarCompleter<Null>(context, localization.restoredPaymentTerm),
          paymentTermIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchivePaymentTermsRequest(
          snackBarCompleter<Null>(context, localization.archivedPaymentTerm),
          paymentTermIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeletePaymentTermsRequest(
          snackBarCompleter<Null>(context, localization.deletedPaymentTerm),
          paymentTermIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.paymentTermListState.isInMultiselect()) {
        store.dispatch(StartPaymentTermMultiselect());
      }

      if (paymentTerms.isEmpty) {
        break;
      }

      for (final paymentTerm in paymentTerms) {
        if (!store.state.paymentTermListState.isSelected(paymentTerm.id)) {
          store.dispatch(AddToPaymentTermMultiselect(entity: paymentTerm));
        } else {
          store.dispatch(RemoveFromPaymentTermMultiselect(entity: paymentTerm));
        }
      }
      break;
  }
}

class StartPaymentTermMultiselect {
  StartPaymentTermMultiselect();
}

class AddToPaymentTermMultiselect {
  AddToPaymentTermMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromPaymentTermMultiselect {
  RemoveFromPaymentTermMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearPaymentTermMultiselect {
  ClearPaymentTermMultiselect();
}
