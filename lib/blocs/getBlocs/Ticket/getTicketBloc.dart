import 'package:rxdart/rxdart.dart';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/resources/TicketApiProvider.dart';

class GetTicketBloc {
  final _ticketProvider = TicketApiProvider();
  final _ticketIds = PublishSubject<List<int>>();
  final _ticketsOutput = BehaviorSubject<Map<int, Future<EventModel>>>();
  final _ticketsFetcher = PublishSubject<int>();

  Stream<List<int>> get getTicketsIds => _ticketIds.stream;
  Stream<Map<int, Future<EventModel>>> get tickets => _ticketsOutput.stream;

  //Getter for sink
  Function(int) get getTicket => _ticketsFetcher.sink.add;

  GetTicketBloc() {
    _ticketsFetcher.stream.transform(_ticketTransformer()).pipe(_ticketsOutput);
  }

  getIds() async {
    List<int> ids = await _ticketProvider.getEventsId();
    if (ids != null) {
      _ticketIds.sink.add(ids);
    }
  }

  _ticketTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<EventModel>> ticket, int id, index) {
      ticket[id] = _ticketProvider.getTicket(id);
      return ticket;
    }, <int, Future<EventModel>>{});
  }

  dispose() {
    _ticketIds.close();
    _ticketsFetcher.close();
    _ticketsOutput.close();
  }
}
