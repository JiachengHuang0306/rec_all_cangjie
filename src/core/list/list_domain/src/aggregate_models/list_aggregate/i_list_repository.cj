package list_domain.aggregate_models.list_aggregate

import naiveseedwork.*

public interface IListRepository <: IRepository<RecAllList> {
    func add(recAllList: RecAllList): Unit

    func update(recAllList: RecAllList): Unit

    func get(listId: Int64): ?RecAllList
}