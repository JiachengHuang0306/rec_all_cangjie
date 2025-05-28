package list_domain.aggregate_models.item_aggregate

import naiveseedwork.*

public interface IItemRepository <: IRepository<RecAllItem> {
    func add(recAllItem: RecAllItem): Unit

    func update(recAllItem: RecAllItem): Unit

    func get(listId: Int64): ?RecAllItem
}