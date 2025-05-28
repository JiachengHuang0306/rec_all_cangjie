package list_domain.aggregate_models.set_aggregate

import naiveseedwork.*

public interface ISetRepository <: IRepository<RecAllSet> {
    func add(recAllSet: RecAllSet): Unit

    func update(recAllSet: RecAllSet): Unit

    func get(listId: Int64): ?RecAllSet
}